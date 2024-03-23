//
//  FollowingRouter.swift
//  ZANI
//
//  Created by 정도현 on 3/23/24.
//

import Foundation
import Alamofire
import SwiftUI

enum FollowingRouter {
  case requestFollowList
}

extension FollowingRouter: BaseRouter {
  
  var path: String {
    switch self {
    case .requestFollowList:
      return "/api/v1/follower"
    }
  }
  
  var method: HTTPMethod {
    switch self {
    case .requestFollowList:
      return .get
    }
  }
  
  var parameters: RequestParams {
    switch self {
    case .requestFollowList:
      return .requestPlain
    }
  }
  
  var header: HeaderType {
    switch self {
    case .requestFollowList:
      return .withToken
    }
  }
}
