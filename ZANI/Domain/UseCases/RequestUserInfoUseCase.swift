//
//  RequestUserInfoUseCase.swift
//  ZANI
//
//  Created by 정도현 on 5/18/24.
//

import Foundation

protocol RequestUserInfoUseCase {
  func execute(
    completion: @escaping (NetworkResult<Any>) -> (Void)
  )
}

final class RequestUserInfoUseCaseImpl: RequestUserInfoUseCase {
  private let userRepository: UserRepository
  
  init(userRepository: UserRepository) {
    self.userRepository = userRepository
  }
  
  func execute(
    completion: @escaping (NetworkResult<Any>) -> (Void)
  ) {
    return userRepository.requestUserInfo(completion: completion)
  }
}
