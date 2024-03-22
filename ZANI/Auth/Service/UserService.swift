//
//  UserService.swift
//  ZANI
//
//  Created by 정도현 on 3/22/24.
//

import Foundation
import Alamofire

final class UserService: BaseService {
  static let shared = UserService()
  
  private override init() {}
}

extension UserService {
  
  func requestUserInfo(completion: @escaping (NetworkResult<Any>) -> (Void)) {
    AFManager.request(UserRouter.requestUserInfo).responseData { response in
      switch response.result {
      case .success:
        guard let statusCode = response.response?.statusCode else { return }
        guard let data = response.data else { return }
        let networkResult = self.judgeStatus(by: statusCode, data, type: UserInfoDTO.self)
        
        completion(networkResult)
        
      case .failure(let err):
        print(err.localizedDescription)
      }
    }
  }
}
