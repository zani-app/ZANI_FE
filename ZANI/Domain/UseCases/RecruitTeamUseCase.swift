//
//  RecruitTeamUseCase.swift
//  ZANI
//
//  Created by 정도현 on 7/16/24.
//

import Foundation

protocol RecruitTeamUseCase {
  
  func requestTeamList(
    data: RequestTeamListDTO,
    completion: @escaping (NetworkResult<Any>) -> Void
  )
  
  func createTeamList(
    data: RequestCreateTeamDTO,
    completion: @escaping (NetworkResult<Any>) -> Void
  )
  
  func applyTeam(
    teamId: Int,
    completion: @escaping (NetworkResult<Any>) -> Void
  )
}

final class RecruitTeamUseCaseImpl: RecruitTeamUseCase {
  private let teamRepository: TeamRepository
  
  init(teamRepository: TeamRepository) {
    self.teamRepository = teamRepository
  }
  
  func requestTeamList(
    data: RequestTeamListDTO,
    completion: @escaping (NetworkResult<Any>) -> Void
  ) {
    teamRepository.requestTeamList(
      data: data,
      completion: completion
    )
  }
  
  func createTeamList(
    data: RequestCreateTeamDTO,
    completion: @escaping (NetworkResult<Any>) -> Void
  ) {
    teamRepository.requestCreateTeam(
      data: data,
      completion: completion
    )
  }
  
  func applyTeam(
    teamId: Int,
    completion: @escaping (NetworkResult<Any>) -> Void
  ) {
    teamRepository.requestApplyTeam(
      teamId: teamId,
      completion: completion
    )
  }
}
