//
//  RequestFollowListUseCase.swift
//  ZANI
//
//  Created by 정도현 on 5/18/24.
//

import Foundation

protocol RequestFollowListUseCase {
  func execute(
    completion: @escaping (NetworkResult<Any>) -> Void
  )
}

final class RequestFollowListUseCaseImpl: RequestFollowListUseCase {
  private let userRepository: UserRepository
  
  init(userRepository: UserRepository) {
    self.userRepository = userRepository
  }
  
  func execute(
    completion: @escaping (NetworkResult<Any>) -> Void
  ) {
    userRepository.requestFollowList(completion: completion)
  }
}
