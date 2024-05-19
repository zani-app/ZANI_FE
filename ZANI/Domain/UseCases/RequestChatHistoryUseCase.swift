//
//  RequestChatHistoryUseCase.swift
//  ZANI
//
//  Created by 정도현 on 5/19/24.
//

import Foundation

protocol RequestChatHistoryUseCase {
  func execute(
    teamId: Int,
    page: Int,
    size: Int,
    completion: @escaping (NetworkResult<Any>) -> Void
  )
}

final class RequestChatHistoryUseCaseImpl: RequestChatHistoryUseCase {
  private let teamRepository: TeamRepository
  
  init(teamRepository: TeamRepository) {
    self.teamRepository = teamRepository
  }
  
  func execute(
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
}
