//
//  RegisterTeamDTO.swift
//  ZANI
//
//  Created by 정도현 on 7/16/24.
//

import Foundation

public struct RegisterTeamDTO: Codable {
  public let userId: Int
  public let teamId: Int
  public let isActive: Bool
  public let isLeader: Bool
  public let lastActiveAt: [Int]?
  public let createdAt: [Int]
  public let currentNum: Int
}
