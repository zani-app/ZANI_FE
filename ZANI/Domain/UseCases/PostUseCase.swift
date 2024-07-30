//
//  PostUseCase.swift
//  ZANI
//
//  Created by 정도현 on 6/4/24.
//

import Foundation
import UIKit

protocol PostUseCase {
  
  func create(
    title: String,
    content: String,
    images: [UIImage],
    completion: @escaping (NetworkResult<Any>) -> Void
  ) -> Void
  
  func read(
    page: Int,
    size: Int,
    keyword: String,
    completion: @escaping (NetworkResult<Any>) -> Void
  ) -> Void
  
  func readDetail(
    postId: Int,
    completion: @escaping (NetworkResult<Any>) -> Void
  ) -> Void
  
  func update(
    postId: Int,
    title: String,
    content: String,
    completion: @escaping (NetworkResult<Any>) -> Void
  ) -> Void
  
  func delete(
    postId: Int,
    completion: @escaping (NetworkResult<Any>) -> Void
  ) -> Void
}

final class PostUseCaseImpl: PostUseCase {
  
  private let postRepository: PostRepository
  
  init(postRepository: PostRepository) {
    self.postRepository = postRepository
  }
  
  func create(
    title: String, 
    content: String,
    images: [UIImage],
    completion: @escaping (NetworkResult<Any>) -> Void
  ) {
    postRepository.createPost(
      title: title,
      content: content,
      images: images,
      completion: completion
    )
  }
  
  func read(
    page: Int,
    size: Int,
    keyword: String,
    completion: @escaping (NetworkResult<Any>) -> Void
  ) {
    postRepository.requestPost(
      page: page,
      size: size,
      keyword: keyword,
      completion: completion
    )
  }
  
  func readDetail(
    postId: Int,
    completion: @escaping (NetworkResult<Any>) -> Void
  ) {
    postRepository.readDetail(
      postId: postId,
      completion: completion
    )
  }
  
  func update(
    postId: Int,
    title: String,
    content: String,
    completion: @escaping (NetworkResult<Any>) -> Void
  ) {
    postRepository.patchPost(
      postId: postId,
      title: title,
      content: content,
      completion: completion
    )
  }
  
  func delete(
    postId: Int,
    completion: @escaping (NetworkResult<Any>) -> Void
  ) {
    postRepository.deletePost(
      postId: postId,
      completion: completion
    )
  }
}
