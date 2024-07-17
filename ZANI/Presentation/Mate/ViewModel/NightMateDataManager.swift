//
//  NightMateDataManager.swift
//  ZANI
//
//  Created by 정도현 on 5/28/24.
//

import Foundation

final class NightMateDataManager: ObservableObject {
  
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
  @Published private(set) var userInfo: UserInfoDTO? = nil
  
  public private(set) var errorMsg: String = ""
  
  // MARK: UseCases
  private let requestUserInfoUseCase: RequestUserInfoUseCaseImpl = RequestUserInfoUseCaseImpl(userRepository: DefaultUserRepository())
  private let nightTeamUseCase: NightTeamUseCaseImpl = NightTeamUseCaseImpl(teamRepository: DefaultTeamRepository())
  
  // MARK: Action
  public enum Action {
    case mainViewAppear
    case tappedLeaveTeamIcon
    case tappedTimelineIcon
  }
  
  public func action(_ action: Action) {
    switch action {
    case .mainViewAppear:
      self.requestUserInfo()
      
    case .tappedLeaveTeamIcon:
      self.requestLeaveTeam()
      
    case .tappedTimelineIcon:
      self.requestMissionTimeline()
      
    default:
      return
    }
  }
}

private extension NightMateDataManager {
  
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
  
  /// 현재 속한 팀에서 탈퇴합니다.
  func requestLeaveTeam() {
    self.viewState = .loading
    
    if let userInfo = userInfo, let teamId = userInfo.teamId {
      nightTeamUseCase.requestLeaveTeam(teamId: teamId) { response in
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
      self.viewState = .failure(errorDescription: "현재 속해있는 팀이 없습니다.")
    }
  }
  
  /// 현재 속한 팀에서 미션 타임라인을 불러옵니다.
  func requestMissionTimeline() {
    self.viewState = .loading
    
    if let userInfo = userInfo, let teamId = userInfo.teamId {
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
    } else {
      self.viewState = .failure(errorDescription: "현재 속해있는 팀이 없습니다.")
    }
  }
}
