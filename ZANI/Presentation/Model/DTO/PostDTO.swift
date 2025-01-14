//
//  ArticleDTO.swift
//  ZANI
//
//  Created by 정도현 on 7/17/24.
//

import Foundation

public struct PostListDTO: Codable, Hashable {
  let hasNext: Bool
  let posts: [PostDTO]
}

public struct PostDTO: Codable, Hashable, Identifiable {
  public var id: Int {
    return self.postId
  }
  let postId: Int
  let postTitle: String
  let likeCount: Int
  let userId: Int
  let nickname: String
  let profileImageUrl: String
  let createdAt: String
}
