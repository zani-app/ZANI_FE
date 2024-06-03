//
//  Router.swift
//  ZANI
//
//  Created by 정도현 on 3/22/24.
//

import Foundation
import Alamofire

public protocol BaseRouter: URLRequestConvertible {
  var baseURL: String { get }
  var method: HTTPMethod { get }
  var path: String { get }
  var parameters: RequestParams { get }
  var header: HeaderType { get }
  var multipart: MultipartFormData { get }
}

public enum HeaderType {
  case plain
  case withToken
}

extension BaseRouter {
  
  // URLRequestConvertible 구현
  func asURLRequest() throws -> URLRequest {
    let url = try baseURL.asURL()
    var urlRequest = try URLRequest(url: url.appendingPathComponent(path), method: method)
    
    urlRequest = self.makeHeaderForRequest(to: urlRequest)
    
    return try self.makeParameterForRequest(to: urlRequest, with: url)
  }
  
  
  private func makeHeaderForRequest(to request: URLRequest) -> URLRequest {
    var request = request
    
    switch header {
    case .plain:
      request.setValue("application/json", forHTTPHeaderField: "Content-Type")
      if let accessToken = UserDefaults.standard.string(forKey: "accessToken") {
        request.setValue("Bearer \(accessToken)", forHTTPHeaderField: "Authorization")
      }
      
    case .withToken:
      request.setValue("application/json", forHTTPHeaderField: "Content-Type")
      if let accessToken = UserDefaults.standard.string(forKey: "accessToken") {
        request.setValue("Bearer \(accessToken)", forHTTPHeaderField: "Authorization")
      }      
    }
    return request
  }
  
  
  private func makeParameterForRequest(to request: URLRequest, with url: URL) throws -> URLRequest {
    var request = request
    
    switch parameters {
      
    case .query(let query, let parameterEncoding):
      request = try parameterEncoding.encode(request, with: query)
      
    case .requestBody(let body, let parameterEncoding):
      request = try parameterEncoding.encode(request, with: body)
      
    case .queryBody(let query, let body, let parameterEncoding, let bodyEncoding):
      request = try parameterEncoding.encode(request, with: query)
      request = try bodyEncoding.encode(request, with: body)
      
    case .requestPlain:
      break
    }
    
    return request
  }
}

// MARK: baseURL & header
extension BaseRouter {
  var baseURL: String {
    return .baseURL
  }
  
  var multipart: MultipartFormData {
    return MultipartFormData()
  }
}

// MARK: ParameterType
public enum RequestParams {
  case queryBody(_ query: [String: Any], _ body: [String: Any], parameterEncoding: ParameterEncoding = URLEncoding(), bodyEncoding: ParameterEncoding = JSONEncoding.default)
  case query(_ query: [String: Any], parameterEncoding: ParameterEncoding = URLEncoding())
  case requestBody(_ body: [String: Any], bodyEncoding: ParameterEncoding = JSONEncoding.default)
  case requestPlain
}

// MARK: toDictionary
extension Encodable {
  func toDictionary() -> [String: Any] {
    guard let data = try? JSONEncoder().encode(self),
          let jsonData = try? JSONSerialization.jsonObject(with: data),
          let dictionaryData = jsonData as? [String: Any] else { return [:] }
    return dictionaryData
  }
}
