//
//  AllNightersService.swift
//  ZANI
//
//  Created by 정도현 on 3/23/24.
//

import Foundation
import Alamofire

final class AllNightersService: BaseService {
  static let shared = AllNightersService()
  
  private override init() {}
}

extension AllNightersService {
  
  /// 유저 정보 조회
  func requestSummary(year: Int, month: Int, completion: @escaping (NetworkResult<Any>) -> Void) {
    AFManager.request(
      AllNightersRouter.requestSummary(year: year, month: month)
    ).responseData { response in
      switch response.result {
      case .success:
        guard let statusCode = response.response?.statusCode else { return }
        guard let data = response.data else { return }
        let networkResult = self.judgeStatus(by: statusCode, data, type: AllNightSummaryDTO.self)
        completion(networkResult)
        
      case .failure(let err):
        print(err.localizedDescription)
      }
    }
  }
}
