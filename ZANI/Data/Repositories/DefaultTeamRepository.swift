//
//  DefaultTeamRepository.swift
//  ZANI
//
//  Created by 정도현 on 5/18/24.
//

import Alamofire
import Foundation

final class DefaultTeamRepository: BaseService, TeamRepository {
  
  public func requestTeamList(data: RequestTeamListDTO, completion: @escaping (NetworkResult<Any>) -> Void) {
    AFManager.request(
      TeamRouter.requestTeamList(
        keyword: data.keyword,
        category: data.category,
        isEmpty: data.isEmpty,
        isSecret: data.isSecret,
        page: data.page,
        size: data.size
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
  
  public func requestCreateTeam(data: RequestCreateTeamDTO, completion: @escaping (NetworkResult<Any>) -> Void) {
    AFManager.request(
      TeamRouter.requestCreateTeam(
        title: data.title,
        maxNum: data.maxNum,
        targetTime: data.targetTime,
        password: data.password,
        category: data.category,
        description: data.description,
        secret: data.secret
      )
    ).responseData { response in
      switch response.result {
      case .success:
        guard let statusCode = response.response?.statusCode else { return }
        guard let data = response.data else { return }
        let networkResult = self.judgeStatus(by: statusCode, data, type: RecruitmentTeamData.self)
        completion(networkResult)
        
      case .failure(let err):
        print(err.localizedDescription)
      }
    }
  }
  
  public func requestChatHistory(
    teamId: Int,
    page: Int,
    size: Int,
    completion: @escaping (NetworkResult<Any>) -> Void
  ) {
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
