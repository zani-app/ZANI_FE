//
//  AllNightersRouter.swift
//  ZANI
//
//  Created by 정도현 on 3/23/24.
//

import Foundation
import Alamofire
import SwiftUI

enum AllNightersRouter {
  case requestSummary(year: Int, month: Int)
  case requestHistory
  case requestCalender(year: Int, month: Int)
}

extension AllNightersRouter: BaseRouter {
  
  var path: String {
    switch self {
    case .requestSummary:
      return "/api/v1/all-nighters/summary"
    case .requestHistory:
      return "/api/v1/all-nighters/history"
    case .requestCalender:
      return "/api/v1/all-nighters/calendar"
    }
  }
  
  var method: HTTPMethod {
    switch self {
    case .requestSummary:
      return .get
    case .requestHistory:
      return .get
    case .requestCalender:
      return .get
    }
  }
  
  var parameters: RequestParams {
    switch self {
    case let .requestSummary(year, month):
      let body: [String: Any] = [
        "year": year,
        "month": month
      ]
      return .requestBody(body, bodyEncoding: URLEncoding.queryString)
      
    // TODO: Multipart
    case .requestHistory:
      return .requestPlain
      
    case let .requestCalender(year, month):
      let body: [String: Any] = [
        "year": year,
        "month": month
      ]
      return .requestBody(body, bodyEncoding: URLEncoding.queryString)
    }
  }
  
  var header: HeaderType {
    switch self {
    case .requestSummary, .requestHistory, .requestCalender:
      return .withToken
    }
  }
}
