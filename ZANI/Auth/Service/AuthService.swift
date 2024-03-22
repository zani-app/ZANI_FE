//
//  AuthService.swift
//  ZANI
//
//  Created by 정도현 on 3/22/24.
//

import Foundation
import Alamofire

final class AuthService: BaseService {
  static let shared = AuthService()
  
  private override init() {}
}

extension AuthService {
  
  func requestSocialSignUp(id: String, provider: AuthProvider, completion: @escaping (NetworkResult<Any>) -> (Void)) {
    AFManager.request(AuthRouter.requestSocialSignUp(id: id, provider: provider)).responseData { response in
      switch response.result {
      case .success:
        guard let statusCode = response.response?.statusCode else { return }
        guard let data = response.data else { return }
        let networkResult = self.judgeStatus(by: statusCode, data, type: SignUpDTO.self)
        
        completion(networkResult)
        
      case .failure(let err):
        print(err.localizedDescription)
      }
    }
  }
}
