//
//  SignUpDTO.swift
//  ZANI
//
//  Created by 정도현 on 3/22/24.
//

import Foundation

public struct SignUpDTO: Codable {
  let accessToken: String
  let refreshToken: String
  
  enum CodingKeys: String, CodingKey {
    case accessToken = "access_token"
    case refreshToken = "refresh_token"
  }
}
