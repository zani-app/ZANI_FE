//
//  RecruitmentManager.swift
//  ZANI
//
//  Created by 정도현 on 3/22/24.
//

import Alamofire
import Combine
import Foundation
import KakaoSDKUser

final class RecruitmentDataManager: ObservableObject {

  // MARK: Variables
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
  @Published private(set) var searchBarState: Bool = false
  @Published var requestTeamData: RequestTeamListDTO = RequestTeamListDTO(
    keyword: "",
    category: "",
    isEmpty: false,
    isSecret: false,
    page: 0,
    size: 10
  )
  @Published var createTeamData: RequestCreateTeamDTO? = nil
  @Published var selectedTeam: RecruitmentTeamData? = nil
  
  public private(set) var userInfo: UserInfoDTO? = nil
  public private(set) var teamList: [RecruitmentTeamData]? = nil
  public private(set) var errorMsg: String = ""
  
  // MARK: UseCase
  private let requestUserInfoUseCase: RequestUserInfoUseCaseImpl = RequestUserInfoUseCaseImpl(userRepository: DefaultUserRepository())
  private let recruitTeamUseCase: RecruitTeamUseCaseImpl = RecruitTeamUseCaseImpl(teamRepository: DefaultTeamRepository())
  
  // MARK: User Action
  public enum Action {
    case mainViewAppear
    case requestTeamList
    case tappedCreateTeam
    case tappedSearchIcon
    case tappedTeam(teamInfo: RecruitmentTeamData)
    case tappedApplyTeam
    case tappedOutsideTeamDetailView
  }
  
  public func action(_ action: Action) {
    switch action {
    case .mainViewAppear:
      self.requestUserInfo()
      self.deInitCreateTeamData()
      self.requestTeamList()
      
    case .requestTeamList:
      self.requestTeamList()
      
    case .tappedCreateTeam:
      self.requestCreateTeam()
      
    case .tappedSearchIcon:
      self.searchBarState.toggle()
      
    case let .tappedTeam(teamInfo: teamData):
      self.selectedTeam = teamData
    
    case .tappedApplyTeam:
      self.requestApplyTeam()
      
    case .tappedOutsideTeamDetailView:
      self.selectedTeam = nil
      
    default:
      return
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
  
  /// 유저 정보를 가져옵니다 - 유저가 속해있는 팀 파악
  func requestUserInfo() {
    requestUserInfoUseCase.execute() { response in
      self.viewState = .loading
      
      switch(response) {
      case .success(let data):
        if let data = data as? UserInfoDTO {
          self.userInfo = data
          self.viewState = .success
        } else {
          self.viewState = .failure(errorDescription: "데이터 오류")
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
  
  /// 현재 생성된 팀 리스트를 요청합니다.
  func requestTeamList() {
    recruitTeamUseCase.requestTeamList(data: requestTeamData) { response in
      self.viewState = .loading
      
      switch(response) {
      case .success(let data):
        if let data = data as? TeamListDTO {
          self.teamList = data.teams
          self.viewState = .success
        } else {
          self.viewState = .failure(errorDescription: "데이터 오류")
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
  
  /// 자신이 선택한 팀에 가입합니다.
  func requestApplyTeam() {
    self.viewState = .loading
    
    if let data = selectedTeam {
      recruitTeamUseCase.applyTeam(teamId: data.id) { response in
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
    } else {
      self.viewState = .failure(errorDescription: "해당 팀 데이터가 존재하지 않습니다.")
    }
    
    self.deInitCreateTeamData()
  }
  
  
  /// 새로운 팀을 생성합니다.
  func requestCreateTeam() {
    self.viewState = .loading
    
    if let data = createTeamData {
      recruitTeamUseCase.createTeamList(data: data) { response in
        
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
  
  /// 생성시킨 팀 데이터 소멸
  func deInitCreateTeamData() {
    self.createTeamData = nil
  }
}
