//
//  BaseService.swift
//  ZANI
//
//  Created by 정도현 on 3/22/24.
//

import Alamofire
import Foundation

class BaseService {
  let AFManager: Session = {
    var session = AF
    let configuration = URLSessionConfiguration.af.default
    //    configuration.timeoutIntervalForRequest = NetworkEnvironment.requestTimeOut
    //    configuration.timeoutIntervalForResource = NetworkEnvironment.resourceTimeOut
    session = Session(configuration: configuration)
    return session
  }()
  
  func judgeStatus<T: Codable>(by statusCode: Int, _ data: Data, type: T.Type) -> NetworkResult<Any> {
    let decoder = JSONDecoder()
    
    guard let decodedData = try? decoder.decode(GeneralResponse<T>.self, from: data) else {
      return .pathErr
    }
    
    switch statusCode {
    case 200..<300:
      return .success(decodedData.data as Any)
      
    case 400..<500:
      return .requestErr(decodedData.error)
      
    case 500:
      return .serverErr
      
    default:
      return .networkFail
    }
  }
}
