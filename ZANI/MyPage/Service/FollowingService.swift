//
//  FollowingService.swift
//  ZANI
//
//  Created by 정도현 on 3/23/24.
//

import Foundation
import Alamofire

final class FollowingService: BaseService {
  static let shared = FollowingService()
  
  private override init() {}
}

extension FollowingService {
  
  /// 유저 정보 조회
  func requestFollowList(completion: @escaping (NetworkResult<Any>) -> Void) {
    AFManager.request(
      MyPageRouter.requestUserInfo
    ).responseData { response in
      switch response.result {
      case .success:
        guard let statusCode = response.response?.statusCode else { return }
        guard let data = response.data else { return }
        let networkResult = self.judgeStatus(by: statusCode, data, type: [FollowDTO].self)
        completion(networkResult)
        
      case .failure(let err):
        print(err.localizedDescription)
      }
    }
  }
}
