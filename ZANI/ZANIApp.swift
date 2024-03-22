//
//  ZANIApp.swift
//  ZANI
//
//  Created by 정도현 on 3/14/24.
//

import SwiftUI
import KakaoSDKCommon
import KakaoSDKAuth

@main
struct ZANIApp: App {
  @StateObject private var authPageManager = AuthPageManager()
  @StateObject private var recruitmentPageManager = RecruitmentPageManager()
  @StateObject private var myPagePageManager = MyPagePageManager()
  
  @UIApplicationDelegateAdaptor var appDelegate: AppDelegate

  var body: some Scene {
    WindowGroup {
//      ContentView()
//        .environmentObject(recruitmentPageManager)
//        .environmentObject(myPagePageManager)
      
      AuthMainView()
        .environmentObject(authPageManager)
    }
  }
}
