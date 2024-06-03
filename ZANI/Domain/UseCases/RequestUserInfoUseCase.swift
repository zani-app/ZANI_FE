//
//  RequestUserInfoUseCase.swift
//  ZANI
//
//  Created by 정도현 on 5/18/24.
//

import Foundation
import UIKit

protocol RequestUserInfoUseCase {
  func execute(
    completion: @escaping (NetworkResult<Any>) -> (Void)
  )
  
  func update(
    image: UIImage?,
    nickname: String?,
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
  
  func update(
    image: UIImage?,
    nickname: String?,
    completion: @escaping (NetworkResult<Any>) -> (Void)
  ) {
    return userRepository.updateUserInfo(
      image: image,
      nickname: nickname,
      completion: completion
    )
  }
}
