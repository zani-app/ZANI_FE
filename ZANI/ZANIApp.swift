//
//  ZANIApp.swift
//  ZANI
//
//  Created by 정도현 on 3/14/24.
//

import SwiftUI

@main
struct ZANIApp: App {
  @StateObject private var authPageManager = AuthPageManager()
  @StateObject private var recruitmentPageManager = RecruitmentPageManager()
  @StateObject private var myPagePageManager = MyPagePageManager()
  
  var body: some Scene {
    WindowGroup {
      ContentView()
        .environmentObject(authPageManager)
        .environmentObject(recruitmentPageManager)
        .environmentObject(myPagePageManager)
    }
  }
}
