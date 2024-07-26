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
    self.route.append(page)
    print(self.route)
  }
  
  func pop() {
    print(self.route)
    if !self.route.isEmpty {
      self.route.removeLast()
    }
  }
  
  func popToRoot() {
    self.route.removeAll()
  }
}
