//
//  FetchUserInfoUseCase.swift
//  ZANI
//
//  Created by 정도현 on 5/18/24.
//

import Foundation

protocol FetchUserInfoUseCase {
  func execute(
    completion: @escaping (NetworkResult<Any>) -> (Void)
  )
}

final class FetchUserInfoUseCaseImpl: FetchUserInfoUseCase {
  private let userRepository: UserRepository
  
  init(userRepository: UserRepository) {
    self.userRepository = userRepository
  }
  
  func execute(
    completion: @escaping (NetworkResult<Any>) -> (Void)
  ) {
    return userRepository.fetchUserInfo(completion: completion)
  }
}

