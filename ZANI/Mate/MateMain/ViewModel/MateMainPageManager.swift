//
//  MatePageManager.swift
//  ZANI
//
//  Created by 강석호 on 3/23/24.
//

import Foundation
import SwiftUI

public enum MateMainPageState {
  case mateRoom
  case chatting
  case timeLine
  case mission
}

final class MateMainPageManager: ObservableObject {
  @Published public var route: [MateMainPageState] = []
  
  func push(_ page: MateMainPageState) {
    route.append(page)
  }
  
  func pop() {
    route.removeLast()
  }
  
  func popToRoot() {
    route.removeAll()
  }
}
