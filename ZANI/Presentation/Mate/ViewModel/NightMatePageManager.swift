//
//  NightMatePageManager.swift
//  ZANI
//
//  Created by 정도현 on 3/29/24.
//

import SwiftUI

public enum NightMatePageState: Hashable {
  case main
  case waitingRoom
  case chatting
  case timeline
  case playMission
}

final class NightMatePageManager: ObservableObject {
  @Published public var route: [NightMatePageState] = []
  
  func push(_ page: NightMatePageState) {
    route.append(page)
  }
  
  func pop() {
    route.removeLast()
  }
  
  func popToRoot() {
    route.removeAll()
  }
}
