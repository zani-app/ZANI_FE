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
  
  /// 닉네임 중복 확인
  func requestNicknameDuplicate(
    nickname: String,
    completion: @escaping (NetworkResult<Any>) -> Void
  ) -> Void
  
  /// 유저 정보 가져오기
  func requestUserInfo(
    completion: @escaping (NetworkResult<Any>) -> (Void)
  ) -> Void
  
  /// 유저 팔로우 정보
  func requestFollowList(
    completion: @escaping (NetworkResult<Any>) -> Void
  ) -> Void
  
  /// 유저 밤샘 정보
  func requestNightSummary(
    year: Int,
    month: Int,
    completion: @escaping (NetworkResult<Any>) -> Void
  ) -> Void
  
  /// 유저 칭호 정보
  func requestAchievement(
    completion: @escaping (NetworkResult<Any>) -> Void
  ) -> Void
}
