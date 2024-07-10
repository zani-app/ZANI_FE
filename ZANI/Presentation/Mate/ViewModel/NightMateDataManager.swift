//
//  NightMateDataManager.swift
//  ZANI
//
//  Created by 정도현 on 5/28/24.
//

import Foundation

final class NightMateDataManager: ObservableObject {
  public enum Action {
    case tappedLeaveTeamIcon(teamId: Int)
    case tappedTimelineIcon(teamId: Int)
  }
  
  @Published private(set) var isUserParticipateTeam: Bool = true  // 현재 유저의 밤샘 진행 여부 -> 서버에서 확인 필요
  
  private let nightTeamUseCase: NightTeamUseCaseImpl = NightTeamUseCaseImpl(teamRepository: DefaultTeamRepository())
  public var viewState: ViewState = .success
  
  public func action(_ action: Action) {
    switch action {
    case let .tappedLeaveTeamIcon(teamId):
      return self.requestLeaveTeam(teamId: teamId)
      
    case let .tappedTimelineIcon(teamId):
      return self.requestMissionTimeline(teamId: teamId)
    }
  }
}

private extension NightMateDataManager {
  
  /// 현재 속한 팀에서 탈퇴합니다.
  func requestLeaveTeam(teamId: Int) {
    nightTeamUseCase.requestLeaveTeam(teamId: teamId) { response in
      switch(response) {
      case .success:
        self.isUserParticipateTeam = false
        
      case .requestErr(let error):
        if let error = error as? ErrorModel {
          print(error.message)
        }
        
      default:
        print("data fetch Error")
      }
    }
  }
  
  /// 현재 속한 팀에서 미션 타임라인을 불러옵니다.
  func requestMissionTimeline(teamId: Int) {
    nightTeamUseCase.requestMissionTimeline(teamId: teamId) { response in
      switch(response) {
      case .success(let data):
        if let data = data as? MissionDTO {
          print(data)
        }
        
      case .requestErr(let error):
        if let error = error as? ErrorModel {
          print(error.message)
        }
        
      default:
        print("data fetch Error")
      }
    }
  }
}
