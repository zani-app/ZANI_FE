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
  
  @Published private(set) var isSuccessTask: Bool = false
  
  @Published var requestTeamData: RequestTeamListDTO = RequestTeamListDTO(
    keyword: "",
    category: "",
    isEmpty: false,
    isSecret: false,
    page: 0,
    size: 10
  )
  @Published var createTeamData: RequestCreateTeamDTO? = nil
  @Published var teamList: [RecruitmentTeamData]? = nil
  
  private var requestTeamListUseCase: RequestTeamListUseCaseImpl = RequestTeamListUseCaseImpl(teamRepository: DefaultTeamRepository())
  private var requestCreateTeamUseCase: RequestCreateTeamUseCaseImpl = RequestCreateTeamUseCaseImpl(teamRepository: DefaultTeamRepository())
  
  public func requestTeamList() {
    requestTeamListUseCase.execute(data: requestTeamData) { response in
      switch(response) {
      case .success(let data):
        if let data = data as? TeamListDTO {
          self.teamList = data.teams
          print(data)
        }
        
      default:
        print("ErrorFetchTeamList")
      }
    }
  }
  
  public func requestCreateTeam() {
    self.isSuccessTask = false
    
    if let data = createTeamData {
      requestCreateTeamUseCase.execute(data: data) { response in
        switch(response) {
        case .success:
          print("success")
          
        default:
          print("failCreateRoom")
        }
        
        self.isSuccessTask = true
        self.deInitCreateTeamData()
      }
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
