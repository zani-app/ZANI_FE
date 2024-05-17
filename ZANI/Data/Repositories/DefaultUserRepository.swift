//
//  DefaultUserRepository.swift
//  ZANI
//
//  Created by 정도현 on 5/18/24.
//

import Foundation
import Alamofire

final class DefaultUserRepository: BaseService, UserRepository {
 
  func requestSocialSignUp(
    id: String,
    provider: AuthProvider,
    completion: @escaping (NetworkResult<Any>) -> (Void)
  ) {
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
  
  func fetchUserInfo(completion: @escaping (NetworkResult<Any>) -> (Void)) {
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
