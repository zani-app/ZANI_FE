//
//  BadgeDTO.swift
//  ZANI
//
//  Created by 정도현 on 7/1/24.
//

import Foundation

public struct BadgeDTO: Codable, Identifiable {
  public let id: String
  public let title: String
  public let content: String
  public let difficulty: String
  public let achievementImageUrl: String
  public let createdAt: [Int]
}
