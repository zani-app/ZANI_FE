//
//  RequestAchievementUseCase.swift
//  ZANI
//
//  Created by 정도현 on 6/2/24.
//

import Foundation

protocol RequestAchievementUseCase {
  func execute(
    completion: @escaping (NetworkResult<Any>) -> Void
  )
}

final class RequestAchievementUseCaseImpl: RequestAchievementUseCase {
  private let userRepository: UserRepository
  
  init(userRepository: UserRepository) {
    self.userRepository = userRepository
  }
  
  func execute(
    completion: @escaping (NetworkResult<Any>) -> Void
  ) {
    userRepository.requestAchievement(
      completion: completion
    )
  }
}
