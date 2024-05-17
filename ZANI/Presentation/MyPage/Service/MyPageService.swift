//
//  MyPageService.swift
//  ZANI
//
//  Created by 정도현 on 3/23/24.
//


import Foundation
import Alamofire
import UIKit

final class MyPageService: BaseService {
  static let shared = MyPageService()
  
  private override init() {}
}

extension MyPageService {
  
  /// 유저 정보 조회
  func requestUserInfo(completion: @escaping (NetworkResult<Any>) -> Void) {
    AFManager.request(
      MyPageRouter.requestUserInfo
    ).responseData { response in
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
  
  /// 닉네임 중복 검색
  func checkNicknameDuplicate(nickname: String, completion: @escaping (NetworkResult<Any>) -> Void) {
    AFManager.request(
      MyPageRouter.checkNicknameDuplicate(nickname: nickname)
    ).responseData { response in
      switch response.result {
      case .success:
        guard let statusCode = response.response?.statusCode else { return }
        guard let data = response.data else { return }
        let networkResult = self.judgeStatus(by: statusCode, data, type: Bool.self)
        completion(networkResult)
        
      case .failure(let err):
        print(err.localizedDescription)
      }
    }
  }
}
