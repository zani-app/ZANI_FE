//
//  RequestNightSummaryUseCase.swift
//  ZANI
//
//  Created by 정도현 on 5/18/24.
//

import Foundation

protocol RequestNightSummaryUseCase {
  func execute(
    year: Int,
    month: Int,
    completion: @escaping (NetworkResult<Any>) -> Void
  )
}

final class RequestNightSummaryUseCaseImpl: RequestNightSummaryUseCase {
  private let userRepository: UserRepository
  
  init(userRepository: UserRepository) {
    self.userRepository = userRepository
  }
  
  func execute(
    year: Int,
    month: Int,
    completion: @escaping (NetworkResult<Any>) -> Void
  ) {
    userRepository.requestNightSummary(
      year: year,
      month: month,
      completion: completion
    )
  }
}
