//
//  AuthRouter.swift
//  ZANI
//
//  Created by 정도현 on 3/22/24.
//

import Foundation
import Alamofire

enum AuthRouter {
  case requestSocialSignUp(id: String, provider: AuthProvider)
}

extension AuthRouter: BaseRouter {
  
  var path: String {
    switch self {
    case .requestSocialSignUp:
      return "/api/v1/oauth/login"
    }
  }
  
  var method: HTTPMethod {
    switch self {
    case .requestSocialSignUp:
      return .post
    }
  }
  
  var parameters: RequestParams {
    switch self {
    case .requestSocialSignUp(let id, let provider):
      let body: [String : Any] = [
        "serialId": id,
        "provider": provider.pathName
      ]
      return .requestParameters(body)
    }
  }
  
  var header: HeaderType {
    switch self {
    case .requestSocialSignUp(id: let id, provider: let provider):
      return .plain
    }
  }
}
