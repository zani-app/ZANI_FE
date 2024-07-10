//
//  UserInfoDTO.swift
//  ZANI
//
//  Created by 정도현 on 3/22/24.
//

import Foundation

public struct UserInfoDTO: Codable {
  let profileImageUrl: String
  let id: Int
  let nickname: String
  let provider: String
  let achievementTitle: String?
  
  enum CodingKeys: String, CodingKey {
    case profileImageUrl = "profile_image_url"
    case id
    case nickname
    case provider
    case achievementTitle = "AchievementTitle"
  }
}
