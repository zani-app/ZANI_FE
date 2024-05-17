//
//  RecruitmentPageManager.swift
//  ZANI
//
//  Created by 정도현 on 3/15/24.
//

import SwiftUI

public enum RecruitmentPageState: Hashable {
  case main
  case createTeam
  case filter
  case category(CreateTeamSection)
}

final class RecruitmentPageManager: ObservableObject {
  @Published public var route: [RecruitmentPageState] = []
  
  func push(_ page: RecruitmentPageState) {
    route.append(page)
  }
  
  func pop() {
    route.removeLast()
  }
  
  func popToRoot() {
    route.removeAll()
  }
}
