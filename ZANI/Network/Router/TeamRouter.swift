//
//  TeamRouter.swift
//  ZANI
//
//  Created by 정도현 on 3/22/24.
//

import Foundation
import Alamofire

enum TeamRouter {
  case requestTeamList(keyword: String, category: String, isEmpty: Bool, isSecret: Bool, page: Int, size: Int)
  case requestCreateTeam(title: String, maxNum: Int, targetTime: Int, password: String, category: String, description: String, secret: Bool)
  case requestLeaveTeam(teamId: Int)
}

extension TeamRouter: BaseRouter { 
  
  var path: String {
    switch self {
    case .requestTeamList:
      return "/api/v1/team"
    case .requestCreateTeam:
      return "/api/v1/team"
    case .requestLeaveTeam(let teamId):
      return "/api/v1/user-team/\(teamId)"
    }
  }
  
  var method: HTTPMethod {
    switch self {
    case .requestTeamList:
      return .get
    case .requestCreateTeam:
      return .post
    case .requestLeaveTeam:
      return .delete
    }
  }
  
  var parameters: RequestParams {
    switch self {
    case let .requestTeamList(keyword, category, isEmpty, isSecret, page, size):
      var body: [String: Any] = [
        "page": page,
        "size": size
      ]
      
      if !keyword.isEmpty {
        body["keyword"] = keyword
      }
      
      if !category.isEmpty {
        body["category"] = category
      }
      
      if !isEmpty {
        body["isEmpty"] = isEmpty
      }
      
      if isSecret {
        body["isSecret"] = isSecret
      }
      
      return .requestBody(body, bodyEncoding: URLEncoding.queryString)
      
    case let .requestCreateTeam(title, maxNum, targetTime, password, category, description, secret):
      let body: [String: Any] = [
        "title": title,
        "maxNum": maxNum,
        "targetTime": targetTime,
        "password": password,
        "category": category,
        "description": description,
        "isSecret": secret
      ]
      return .requestBody(body, bodyEncoding: JSONEncoding.default)
      
    case let .requestLeaveTeam(teamId):
      let body: [String: Any] = [
        "teamId": teamId
      ]
      return .requestBody(body, bodyEncoding: URLEncoding.queryString)
    }
  }
  
  var header: HeaderType {
    switch self {
    case .requestTeamList, .requestCreateTeam, .requestLeaveTeam:
      return .withToken
    }
  }
}
