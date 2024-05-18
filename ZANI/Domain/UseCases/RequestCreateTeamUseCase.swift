//
//  RequestCreateTeamUseCase.swift
//  ZANI
//
//  Created by 정도현 on 5/18/24.
//

import Foundation

protocol RequestCreateTeamUseCase {
  func execute(
    data: RequestCreateTeamDTO,
    completion: @escaping (NetworkResult<Any>) -> Void
  )
}

final class RequestCreateTeamUseCaseImpl: RequestCreateTeamUseCase {
  private let teamRepository: TeamRepository
  
  init(teamRepository: TeamRepository) {
    self.teamRepository = teamRepository
  }
  
  func execute(
    data: RequestCreateTeamDTO,
    completion: @escaping (NetworkResult<Any>) -> Void
  ) {
    teamRepository.requestCreateTeam(
      data: data,
      completion: completion
    )
  }
}
