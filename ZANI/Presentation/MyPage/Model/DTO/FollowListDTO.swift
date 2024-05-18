//
//  FollowListDTO.swift
//  ZANI
//
//  Created by 정도현 on 3/23/24.
//

import Foundation

public struct FollowDTO: Codable, Hashable {
  let userId: Int
  let nickname: String
  let title: String?
}
