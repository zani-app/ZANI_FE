//
//  MyPageRouter.swift
//  ZANI
//
//  Created by 정도현 on 3/23/24.
//

import Foundation
import Alamofire
import SwiftUI

enum MyPageRouter {
  case requestUserInfo
  case updateUserInfo(nickname: String, image: UIImage)
  case checkNicknameDuplicate(nickname: String)
}

extension MyPageRouter: BaseRouter {
  
  var path: String {
    switch self {
    case .requestUserInfo:
      return "/api/v1/user"
    case .updateUserInfo:
      return "/api/v1/user"
    case .checkNicknameDuplicate:
      return "/api/v1/user/nickname-duplicate"
    }
  }
  
  var method: HTTPMethod {
    switch self {
    case .requestUserInfo:
      return .get
    case .updateUserInfo:
      return .patch
    case .checkNicknameDuplicate:
      return .get
    }
  }
  
  var parameters: RequestParams {
    switch self {
    case .requestUserInfo:
      return .requestPlain
      
    // TODO: Multipart
    case let .updateUserInfo(nickname, image):
      return .requestPlain
      
    case let .checkNicknameDuplicate(nickname: nickname):
      let body: [String: Any] = [
        "nickname": nickname
      ]
      return .requestBody(body, bodyEncoding: URLEncoding.queryString)
    }
  }
  
  var header: HeaderType {
    switch self {
    case .requestUserInfo, .updateUserInfo, .checkNicknameDuplicate:
      return .withToken
    }
  }
}
