//
//  TeamRepository.swift
//  ZANI
//
//  Created by 정도현 on 5/18/24.
//

import Foundation

protocol TeamRepository {
  
  /// 팀 리스트 불러오기
  func requestTeamList(
    data: RequestTeamListDTO,
    completion: @escaping (NetworkResult<Any>) -> Void
  ) -> Void
  
  /// 팀 생성
  func requestCreateTeam(
    data: RequestCreateTeamDTO,
    completion: @escaping (NetworkResult<Any>) -> Void
  ) -> Void
}
