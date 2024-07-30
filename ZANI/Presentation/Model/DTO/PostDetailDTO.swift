//
//  PostDetailDTO.swift
//  ZANI
//
//  Created by 정도현 on 7/26/24.
//

import Foundation

public struct PostDetailDTO: Codable, Hashable {
  public let postId: Int
  public let postTitle: String
  public let postContent: String
  public let likeCount: Int
  public let userId: Int
  public let profileImageUrl: String
  public let createdAt: String
  public let updatedAt: String
  public let commentsDto: [PostCommentDTO]
  public let postImageUrl: [String]
}
