//
//  ChattingService.swift
//  ZANI
//
//  Created by 정도현 on 3/24/24.
//

import Foundation
import Alamofire
import UIKit

final class ChattingService: BaseService {
  static let shared = ChattingService()
  
  private override init() {}
}

extension ChattingService {
  
  /// 유저 정보 조회
  func requestChattingHistory(teamId: Int, page: Int, size: Int, completion: @escaping (NetworkResult<Any>) -> Void) {
    AFManager.request(
      ChattingRouter.requestChattingHistory(teamId: teamId, page: page, size: size)
    ).responseData { response in
      switch response.result {
      case .success:
        guard let statusCode = response.response?.statusCode else { return }
        guard let data = response.data else { return }
        let networkResult = self.judgeStatus(by: statusCode, data, type: ChatDTO.self)
        completion(networkResult)
        
      case .failure(let err):
        print(err.localizedDescription)
      }
    }
  }
}
