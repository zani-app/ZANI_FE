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
  
  /// 팀 가입
  func requestApplyTeam(
    teamId: Int,
    completion: @escaping (NetworkResult<Any>) -> Void
  ) -> Void
  
  /// 팀의 채팅 기록
  func requestChatHistory(
    teamId: Int,
    page: Int,
    size: Int, 
    completion: @escaping (NetworkResult<Any>) -> Void
  ) -> Void
  
  /// 팀 미션 기록
  func requestMissionTimeline(
    teamId: Int,
    completion: @escaping (NetworkResult<Any>) -> Void
  ) -> Void
  
  /// 팀 나가기
  func requestLeaveTeam(
    teamId: Int,
    completion: @escaping (NetworkResult<Any>) -> Void
  ) -> Void
}
