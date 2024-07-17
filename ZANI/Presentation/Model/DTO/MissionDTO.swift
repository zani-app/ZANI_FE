//
//  MissionDTO.swift
//  ZANI
//
//  Created by 정도현 on 7/7/24.
//

import Foundation

public struct MissionDTO: Codable, Hashable {
  let missionId: Int
  let userTeamId: Int
  let userId: Int
  let nickname: String
  let profileImageUrl: String
  let issuedAt: [Int]
  let result: Bool
  let resultImageUrl: String?
  let resultText: String
}
