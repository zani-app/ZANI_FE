//
//  ChattingRouter.swift
//  ZANI
//
//  Created by 정도현 on 3/24/24.
//

import Foundation
import Alamofire
import SwiftUI

enum ChattingRouter {
  case requestChattingHistory(teamId: Int, page: Int, size: Int)
}

extension ChattingRouter: BaseRouter {
  
  var path: String {
    switch self {
    case let .requestChattingHistory(teamId, page, size):
      return "/api/v1/chats/\(teamId)/chat"
    }
  }
  
  var method: HTTPMethod {
    switch self {
    case .requestChattingHistory:
      return .get
    }
  }
  
  var parameters: RequestParams {
    switch self {
    case let .requestChattingHistory(teamId, page, size):
      let body: [String: Any] = [
        "teamId": teamId,
        "page": page,
        "size": size
      ]
      
      return .requestBody(body, bodyEncoding: URLEncoding.queryString)
    }
  }
  
  var header: HeaderType {
    switch self {
    case .requestChattingHistory:
      return .withToken
    }
  }
}
