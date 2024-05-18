//
//  RequestSocialSignUpUseCase.swift
//  ZANI
//
//  Created by 정도현 on 5/18/24.
//

import Foundation

protocol RequestSocialSignUpUseCase {
  func execute(
    id: String,
    provider: AuthProvider,
    completion: @escaping (NetworkResult<Any>) -> (Void)
  )
}

final class RequestSocialSignUpUseCaseImpl: RequestSocialSignUpUseCase {
  private let userRepository: UserRepository
  
  init(userRepository: UserRepository) {
    self.userRepository = userRepository
  }
  
  func execute(
    id: String,
    provider: AuthProvider,
    completion: @escaping (NetworkResult<Any>) -> (Void)
  ) {
    return userRepository.requestSocialSignUp(
      id: id,
      provider: provider,
      completion: completion
    )
  }
}
