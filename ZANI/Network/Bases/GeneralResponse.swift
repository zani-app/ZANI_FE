//
//  GeneralResponse.swift
//  ZANI
//
//  Created by 정도현 on 3/22/24.
//

import Foundation

struct GeneralResponse<T> {
  let success: Bool
  let data: T?
  let error: ErrorModel?
  
  enum CodingKeys: String, CodingKey {
    case success
    case data
    case error
  }
}

extension GeneralResponse: Decodable where T: Decodable  {
  init(from decoder: Decoder) throws {
    let container = try decoder.container(keyedBy: CodingKeys.self)
    success = try container.decode(Bool.self, forKey: .success)
    data = try? container.decode(T.self, forKey: .data)
    error = try? container.decode(ErrorModel.self, forKey: .error)
  }
}

public struct ErrorModel: Codable {
  let code: Int
  let message: String
}
