//
//  RequestLeaveTeamUseCase.swift
//  ZANI
//
//  Created by 정도현 on 5/28/24.
//

import Foundation

protocol RequestLeaveTeamUseCase {
  func execute(
    teamId: Int,
    completion: @escaping (NetworkResult<Any>) -> Void
  )
}

final class RequestLeaveTeamUseCaseImpl: RequestLeaveTeamUseCase {
  private let teamRepository: TeamRepository
  
  init(teamRepository: TeamRepository) {
    self.teamRepository = teamRepository
  }
  
  func execute(
    teamId: Int,
    completion: @escaping (NetworkResult<Any>) -> Void
  ) {
    teamRepository.requestLeaveTeam(
      teamId: teamId,
      completion: completion
    )
  }
}
