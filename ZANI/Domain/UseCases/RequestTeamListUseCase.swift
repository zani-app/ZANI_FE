//
//  RequestTeamListUseCase.swift
//  ZANI
//
//  Created by 정도현 on 5/18/24.
//

import Foundation

protocol RequestTeamListUseCase {
  func execute(
    data: RequestTeamListDTO,
    completion: @escaping (NetworkResult<Any>) -> Void
  )
}

final class RequestTeamListUseCaseImpl: RequestTeamListUseCase {
  private let teamRepository: TeamRepository
  
  init(teamRepository: TeamRepository) {
    self.teamRepository = teamRepository
  }
  
  func execute(
    data: RequestTeamListDTO,
    completion: @escaping (NetworkResult<Any>) -> Void
  ) {
    teamRepository.requestTeamList(
      data: data,
      completion: completion
    )
  }
}
