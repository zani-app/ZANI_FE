//
//  CommunityPageManager.swift
//  ZANI
//
//  Created by 정도현 on 3/31/24.
//

import SwiftUI

public enum CommunityPageState: Hashable {
  case main
  case writing
  case detail
}

final class CommunityPageManager: ObservableObject {
  @Published public var route: [CommunityPageState] = []
  
  func push(_ page: CommunityPageState) {
    route.append(page)
  }
  
  func pop() {
    route.removeLast()
  }
  
  func popToRoot() {
    route.removeAll()
  }
}
