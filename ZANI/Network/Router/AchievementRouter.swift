//
//  AchievementRouter.swift
//  ZANI
//
//  Created by 정도현 on 6/2/24.
//

import Foundation
import Alamofire

enum AchievementRouter {
  case requestAchievement
}

extension AchievementRouter: BaseRouter {
  
  var path: String {
    switch self {
    case .requestAchievement:
      return "/api/v1/achievement"
    }
  }
  
  var method: HTTPMethod {
    switch self {
    case .requestAchievement:
      return .get
    }
  }
  
  var parameters: RequestParams {
    switch self {
    case .requestAchievement:
      return .requestPlain
    }
  }
  
  var header: HeaderType {
    switch self {
    case .requestAchievement:
      return .withToken
    }
  }
}
