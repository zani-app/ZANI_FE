//
//  TeamService.swift
//  ZANI
//
//  Created by 정도현 on 3/22/24.
//

import Foundation
import Alamofire

final class TeamService: BaseService {
  static let shared = TeamService()
  
  private override init() {}
}

extension TeamService {
  func requestTeamList(keyword: String, category: String, isEmpty: Bool, isPublic: Bool, page: Int, size: Int, completion: @escaping (NetworkResult<Any>) -> Void) {
    AFManager.request(
      TeamRouter.requestTeamList(
        keyword: keyword,
        category: category,
        isEmpty: isEmpty,
        isPublic: isPublic,
        page: page,
        size: size
      )
    ).responseData { response in
      switch response.result {
      case .success:
        guard let statusCode = response.response?.statusCode else { return }
        guard let data = response.data else { return }
        let networkResult = self.judgeStatus(by: statusCode, data, type: TeamListDTO.self)
        completion(networkResult)
        
      case .failure(let err):
        print(err.localizedDescription)
      }
    }
  }
}
