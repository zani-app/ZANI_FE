//
//  PostRouter.swift
//  ZANI
//
//  Created by 정도현 on 6/4/24.
//

import Foundation
import Alamofire

enum PostRouter {
  case requestPost(page: Int, size: Int, keyword: String)
  case createPost(title: String, content: String)
  case updatePost(postId: Int, title: String, content: String)
  case deletePost(postId: Int)
}

extension PostRouter: BaseRouter {
  
  var path: String {
    switch self {
    case .requestPost, .createPost:
      return "/api/v1/post"
    case .updatePost(let postId, _, _):
      return "/api/v1/post/\(postId)"
    case .deletePost(let postId):
      return "/api/v1/post/\(postId)"
    }
  }
  
  var method: HTTPMethod {
    switch self {
    case .requestPost:
      return .get
    case .createPost:
      return .post
    case .updatePost:
      return .patch
    case .deletePost:
      return .delete
    }
  }
  
  var parameters: RequestParams {
    switch self {
    case let .requestPost(page, size, keyword):
      let query: [String: Any] = [
        "page": page,
        "size": size,
        "keyword": keyword
      ]
      return .requestBody(query, bodyEncoding: URLEncoding.queryString)
      
    case let .createPost(title, content):
      let body: [String: Any] = [
        "title": title,
        "content": content
      ]
      return .requestBody(body, bodyEncoding: JSONEncoding.default)
      
    case let .updatePost(postId, title, content):
      let query: [String: Any] = [
        "postId": postId,
      ]
      
      let body: [String: Any] = [
        "title": title,
        "content": content
      ]
      
      return .queryBody(
        query,
        body,
        parameterEncoding: URLEncoding.queryString,
        bodyEncoding: URLEncoding.httpBody
      )
      
    case let .deletePost(postId):
      let query: [String: Any] = [
        "postId": postId,
      ]
      
      return .requestBody(query, bodyEncoding: URLEncoding.queryString)
    }
  }
  
  var header: HeaderType {
    switch self {
    default:
      return .withToken
    }
  }
}
