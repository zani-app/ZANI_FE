//
//  RecruitmentPageManager.swift
//  ZANI
//
//  Created by 정도현 on 3/15/24.
//

import SwiftUI

enum RecruitmentPageState {
  case main
  case filter
  case createTeam
  case category
  case peopleCount
  case nightTime
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
