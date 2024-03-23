//
//  UserRouter.swift
//  ZANI
//
//  Created by 정도현 on 3/22/24.
//

import Foundation
import Alamofire

enum UserRouter {
  case requestUserInfo
}

extension UserRouter: BaseRouter {
  
  var path: String {
    switch self {
    case .requestUserInfo:
      return "/api/v1/user"
    }
  }
  
  var method: HTTPMethod {
    switch self {
    case .requestUserInfo:
      return .get
    }
  }
  
  var parameters: RequestParams {
    switch self {
    case .requestUserInfo:
      return .requestPlain
    }
  }
  
  var header: HeaderType {
    switch self {
    case .requestUserInfo:
      return .withToken
    }
  }
}
