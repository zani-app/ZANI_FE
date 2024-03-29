//
//  TeamListDTO.swift
//  ZANI
//
//  Created by 정도현 on 3/22/24.
//

import Foundation

public struct TeamListDTO: Codable, Hashable {
  let teams: [RecruitmentTeamData]
  let hasNext: Bool
}

public struct RecruitmentTeamData: Codable, Hashable {
  let id: Int
  let title: String
  let maxNum: Int
  let currentNum: Int
  let targetTime: Int
  let isSecret: Bool
  let password: String?
  let category: String
  let description: String
  let createdAt: [Int]
}
