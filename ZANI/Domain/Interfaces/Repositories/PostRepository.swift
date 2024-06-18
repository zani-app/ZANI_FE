//
//  PostRepository.swift
//  ZANI
//
//  Created by 정도현 on 6/4/24.
//

import Foundation

protocol PostRepository {
  
  /// 게시글 리스트 불러오기
  func requestPost(
    page: Int,
    size: Int,
    keyword: String,
    completion: @escaping (NetworkResult<Any>) -> Void
  ) -> Void
  
  /// 게시글 생성
  func createPost(
    title: String,
    content: String,
    completion: @escaping (NetworkResult<Any>) -> Void
  ) -> Void
  
  /// 게시글 업데이트
  func patchPost(
    postId: Int,
    title: String,
    content: String,
    completion: @escaping (NetworkResult<Any>) -> Void
  ) -> Void
  
  /// 게시글 삭제
  func deletePost(
    postId: Int,
    completion: @escaping (NetworkResult<Any>) -> Void
  ) -> Void
}
