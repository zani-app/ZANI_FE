//
//  RequestNicknameDuplicateUseCase.swift
//  ZANI
//
//  Created by 정도현 on 5/18/24.
//

import Foundation

protocol RequestNicknameDuplicateUseCase {
  func execute(
    nickname: String,
    completion: @escaping (NetworkResult<Any>) -> Void
  )
}

final class RequestNicknameDuplicateUseCaseImpl: RequestNicknameDuplicateUseCase {
  private let userRepository: UserRepository
  
  init(userRepository: UserRepository) {
    self.userRepository = userRepository
  }
  
  func execute(
    nickname: String,
    completion: @escaping (NetworkResult<Any>) -> Void
  ) {
    userRepository.requestNicknameDuplicate(
      nickname: nickname, 
      completion: completion
    )
  }
}
