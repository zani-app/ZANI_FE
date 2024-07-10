//
//  AllNightSummaryDTO.swift
//  ZANI
//
//  Created by 정도현 on 3/23/24.
//

import Foundation

public struct AllNightSummaryDTO: Codable, Hashable {
  let totalDuration: Int
  let totalAllNighters: Int
  let allNightersRecords: [NightRecordDTO]
}

public struct NightRecordDTO: Codable, Hashable {
  let historyTeamId: Int
  let startAt: [Int]
  let endAt: [Int]
  let duration: Int
}
