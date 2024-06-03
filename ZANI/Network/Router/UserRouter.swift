//
//  UserRouter.swift
//  ZANI
//
//  Created by 정도현 on 3/22/24.
//

import Foundation
import Alamofire
import UIKit

enum UserRouter {
  case requestUserInfo
  case updateUserInfo(image: UIImage?, nickname: String?)
}

extension UserRouter: BaseRouter {
  
  var path: String {
    switch self {
    case .requestUserInfo:
      return "/api/v1/user"
    case .updateUserInfo:
      return "/api/v1/user"
    }
  }
  
  var method: HTTPMethod {
    switch self {
    case .requestUserInfo:
      return .get
    case .updateUserInfo:
      return .patch
    }
  }
  
  var parameters: RequestParams {
    switch self {
    case .requestUserInfo:
      return .requestPlain
      
    default:
      return .requestPlain
    }
  }
  
  var header: HeaderType {
    switch self {
    case .requestUserInfo:
      return .withToken
      
    case .updateUserInfo:
      return .withToken
    }
  }
  
  var multipart: MultipartFormData {
    switch self {
    case .updateUserInfo(let image, let nickname):
      let multiPart = MultipartFormData()
      
      if let nickname = nickname {
        multiPart.append(nickname.data(using: .utf8) ?? Data(), withName: "nickname")
      }
      
      if let image = image?.pngData() {
        multiPart.append(
          image,
          withName: "file",
          fileName: "\(image).png",
          mimeType: "image/png"
        )
      }
      return multiPart
      
    default: 
      return MultipartFormData()
    }
  }
}
