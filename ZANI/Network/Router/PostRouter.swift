//
//  PostRouter.swift
//  ZANI
//
//  Created by 정도현 on 6/4/24.
//

import Alamofire
import Foundation
import UIKit

enum PostRouter {
  case requestPost(page: Int, size: Int, keyword: String)
  case createPost(title: String, content: String, images: [UIImage])
  case updatePost(postId: Int, title: String, content: String)
  case fetchDetailPost(postId: Int)
  case deletePost(postId: Int)
}

extension PostRouter: BaseRouter {
  
  var path: String {
    switch self {
    case .requestPost, .createPost:
      return "/api/v1/post"
    case .updatePost(let postId, _, _):
      return "/api/v1/post/\(postId)"
    case .fetchDetailPost(postId: let postId):
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
    case .fetchDetailPost:
      return .get
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
      
    case .createPost:
      return .requestPlain
      
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
      
    case let .fetchDetailPost(postId):
      let query: [String: Any] = [
        "postId": postId,
      ]
      return .requestBody(query, bodyEncoding: URLEncoding.queryString)
      
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
  
  var multipart: MultipartFormData {
    switch self {
    case let .createPost(title, content, images):
      let multiPart = MultipartFormData()
      
      let post: [String: Any] = ["title": title, "content": content]
      
      if let postData = try? JSONSerialization.data(withJSONObject: post) {
        multiPart.append(postData, withName: "post", mimeType: "application/json")
      }
      
      if !images.isEmpty {
        for image in images {
          if let image = image.pngData() {
            multiPart.append(
              image,
              withName: "photos",
              fileName: "\(image).png",
              mimeType: "image/png"
            )
          }
        }
      }
      
      return multiPart
      
    default:
      return MultipartFormData()
    }
  }
}
