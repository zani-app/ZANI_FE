//
//  UserRepository.swift
//  ZANI
//
//  Created by 정도현 on 5/18/24.
//

import Foundation

protocol UserRepository {
  /// 소셜 로그인
  func requestSocialSignUp(
    id: String,
    provider: AuthProvider,
    completion: @escaping (NetworkResult<Any>) -> (Void)
  ) -> Void
  
  /// 유저 정보 가져오기
  func fetchUserInfo(
    completion: @escaping (NetworkResult<Any>) -> (Void)
  ) -> Void
}
