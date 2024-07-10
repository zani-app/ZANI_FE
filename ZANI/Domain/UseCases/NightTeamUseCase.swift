//
//  NightTeamUseCase.swift
//  ZANI
//
//  Created by 정도현 on 7/7/24.
//

import Foundation

protocol NightTeamUseCase {
  func requestChatHistory(
    teamId: Int,
    page: Int,
    size: Int,
    completion: @escaping (NetworkResult<Any>) -> Void
  )
  
  func requestMissionTimeline(
    teamId: Int,
    completion: @escaping (NetworkResult<Any>) -> Void
  )
  
  func requestLeaveTeam(
    teamId: Int,
    completion: @escaping (NetworkResult<Any>) -> Void
  )
}

final class NightTeamUseCaseImpl: NightTeamUseCase {
  private let teamRepository: TeamRepository
  
  init(teamRepository: TeamRepository) {
    self.teamRepository = teamRepository
  }
  
  func requestChatHistory(
    teamId: Int,
    page: Int,
    size: Int,
    completion: @escaping (NetworkResult<Any>) -> Void
  ) {
    teamRepository.requestChatHistory(
      teamId: teamId,
      page: page,
      size: size,
      completion: completion
    )
  }
  
  func requestMissionTimeline(
    teamId: Int,
    completion: @escaping (NetworkResult<Any>) -> Void
  ) {
    teamRepository.requestMissionTimeline(
      teamId: teamId,
      completion: completion
    )
  }
  
  func requestLeaveTeam(
    teamId: Int,
    completion: @escaping (NetworkResult<Any>) -> Void
  ) {
    teamRepository.requestLeaveTeam(
      teamId: teamId,
      completion: completion
    )
  }
}
