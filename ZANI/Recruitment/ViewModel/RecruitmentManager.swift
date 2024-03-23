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

final class RecruitmentManager: ObservableObject {
  
  @Published var keyword: String = ""
  @Published var category: String = ""
  @Published var isEmpty: Bool = false
  @Published var isSecret: Bool = false
  @Published var page: Int = 0
  @Published var size: Int = 10
  
  @Published var teamList: [Team]? = nil
  
  
  /// for create Room
  @Published var teamName: String = ""
  @Published var teamCategory: String = ""
  @Published var maxNum: Int? = nil
  @Published var targetTime: Int? = nil
  @Published var teamDescription: String = ""
  @Published var isSecretRoom: Bool = false
  @Published var password: String = ""
  
  func requestTeamList() {
    TeamService.shared.requestTeamList(keyword: keyword, category: category, isEmpty: isEmpty, isSecret: isSecret, page: page, size: size) { response in
      switch(response) {
      case .success(let data):
        if let data = data as? TeamListDTO {
          self.teamList = data.teams
          print(data.teams)
        }
        
      default:
        print("ErrorFetchTeamList")
      }
    }
  }
  
  func requestCreateTeam() {
    TeamService.shared.requestCreateTeam(title: teamName, maxNum: maxNum!, targetTime: targetTime!, password: password, category: teamCategory, description: teamDescription, secret: isSecretRoom) { response in
      switch(response) {
      case .success(let data):
        if let data = data as? Team {
          print("success")
        }
        
      default:
        print("failCreateRoom")
      }
    }
  }
  
  
  func deInitCreateTeamData() {
    self.teamName = ""
    self.teamCategory = ""
    self.maxNum = nil
    self.targetTime = nil
    self.teamDescription = ""
    self.isSecretRoom = false
    self.password = ""
  }
}
