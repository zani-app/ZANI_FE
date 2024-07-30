//
//  PostCommentDTO.swift
//  ZANI
//
//  Created by 정도현 on 7/26/24.
//

import Foundation

public struct PostCommentDTO: Codable, Hashable {
  public let commentId: Int
  public let userId: Int
  public let nickname: String
  public let profileImageUrl: String
  public let commentContent: String
  public let createdAt: String
  public let updatedAt: String
}
