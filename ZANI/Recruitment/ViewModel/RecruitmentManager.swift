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
  @Published var isPublic: Bool = true
  @Published var page: Int = 0
  @Published var size: Int = 10
  
  @Published var teamList: [Team]? = nil
  
  func requestTeamList() {
    TeamService.shared.requestTeamList(keyword: keyword, category: category, isEmpty: isEmpty, isPublic: isPublic, page: page, size: size) { response in
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
}
