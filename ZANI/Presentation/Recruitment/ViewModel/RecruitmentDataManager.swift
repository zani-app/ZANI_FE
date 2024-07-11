//
//  RecruitmentManager.swift
//  ZANI
//
//  Created by 정도현 on 3/22/24.
//

import Combine
import Foundation
import KakaoSDKUser
import Alamofire

final class RecruitmentDataManager: ObservableObject {
  
  public enum Action {
    case mainViewAppear
    case requestTeamList
    case tappedCreateTeam
  }
  
  // MARK: Variables
  @Published var requestTeamData: RequestTeamListDTO = RequestTeamListDTO(
    keyword: "",
    category: "",
    isEmpty: false,
    isSecret: false,
    page: 0,
    size: 10
  )
  @Published var createTeamData: RequestCreateTeamDTO? = nil
  @Published var viewState: ViewState = .success {
    didSet {
      switch viewState {
      case .failure(let errorDescription):
        self.errorMsg = errorDescription
        
      default:
        self.errorMsg = ""
      }
    }
  }
  
  public var teamList: [RecruitmentTeamData]? = nil
  public var errorMsg: String = ""
  
  // MARK: UseCase
  private let requestTeamListUseCase: RequestTeamListUseCaseImpl = RequestTeamListUseCaseImpl(teamRepository: DefaultTeamRepository())
  private let requestCreateTeamUseCase: RequestCreateTeamUseCaseImpl = RequestCreateTeamUseCaseImpl(teamRepository: DefaultTeamRepository())
  
  public func action(_ action: Action) {
    switch action {
    case .mainViewAppear:
      self.requestTeamData.keyword = ""
      return self.requestTeamList()
      
    case .requestTeamList:
      return self.requestTeamList()
      
    case .tappedCreateTeam:
      return self.requestCreateTeam()
    }
  }
  
  public func allocCreateTeamData() {
    self.createTeamData = RequestCreateTeamDTO(
      title: "",
      maxNum: 0,
      targetTime: 0,
      password: "",
      category: "",
      description: "",
      secret: false
    )
  }
  
  public func deInitCreateTeamData() {
    self.createTeamData = nil
  }
  
  public func validateCreateTeamData() -> Bool {
    if let data = self.createTeamData {
      return !data.title.isEmpty &&
      !data.category.isEmpty &&
      data.maxNum != 0 &&
      data.targetTime != 0 &&
      !data.description.isEmpty &&
      (!data.secret || !data.password.isEmpty)
    } else {
      return false
    }
  }
}

private extension RecruitmentDataManager {
  
  /// 현재 생성된 팀 리스트를 요청합니다.
  func requestTeamList() {
    requestTeamListUseCase.execute(data: requestTeamData) { response in
      self.viewState = .loading
      
      switch(response) {
      case .success(let data):
        if let data = data as? TeamListDTO {
          self.teamList = data.teams
          self.viewState = .success
        }
        
      case .requestErr(let error):
        if let error = error as? ErrorModel {
          self.viewState = .failure(errorDescription: error.message)
        }
        
      default:
        self.viewState = .failure(errorDescription: "error")
      }
    }
  }
  
  /// 새로운 팀을 생성합니다.
  func requestCreateTeam() {
    self.viewState = .loading
    
    if let data = createTeamData {
      requestCreateTeamUseCase.execute(data: data) { response in
        
        switch(response) {
        case .success:
          self.viewState = .success
          
        case .requestErr(let error):
          if let error = error as? ErrorModel {
            self.viewState = .failure(errorDescription: error.message)
          }
          
        default:
          self.viewState = .failure(errorDescription: "error")
        }
      }
    }
    
    self.deInitCreateTeamData()
  }
}
