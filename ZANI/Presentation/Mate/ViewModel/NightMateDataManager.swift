//
//  NightMateDataManager.swift
//  ZANI
//
//  Created by 정도현 on 5/28/24.
//

import Foundation

final class NightMateDataManager: ObservableObject {
  @Published private(set) var isUserParticipateTeam: Bool = true  // 현재 유저의 밤샘 진행 여부
  
  private var requestLeaveTeamUseCaseImpl: RequestLeaveTeamUseCaseImpl = RequestLeaveTeamUseCaseImpl(teamRepository: DefaultTeamRepository())
  
  public func requestLeaveTeam(teamId: Int) {
    requestLeaveTeamUseCaseImpl.execute(teamId: teamId) { response in
      switch(response) {
      case .success:
        self.isUserParticipateTeam = false
        
      default:
        print("data fetch Error")
      }
    }
  }
}
