//
//  MyPagePageManager.swift
//  ZANI
//
//  Created by 정도현 on 3/20/24.
//

import SwiftUI

public enum MyPagePageState {
  case main
  case changeNickname
  case mateDetail
  case timeLine
  case followerDetail
}

final class MyPagePageManager: ObservableObject {
  @Published public var route: [MyPagePageState] = []
  
  func push(_ page: MyPagePageState) {
    route.append(page)
  }
  
  func pop() {
    route.removeLast()
  }
  
  func popToRoot() {
    route.removeAll()
  }
}
