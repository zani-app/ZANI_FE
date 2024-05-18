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
  @StateObject private var nightMatePageManager = NightMatePageManager()
  @StateObject private var recruitmentPageManager = RecruitmentPageManager()
  
  @StateObject private var authDataManager = AuthDataManager()
  @StateObject private var recruitmentManager = RecruitmentManager()
  @StateObject private var stompManager = StompClient()
  @StateObject private var chattingManager = ChattingManager()
  
  @UIApplicationDelegateAdaptor var appDelegate: AppDelegate
  
  var body: some Scene {
    WindowGroup {
      if authDataManager.isLogin {
        ContentView()
          .environmentObject(nightMatePageManager)
          .environmentObject(recruitmentPageManager)
          .environmentObject(recruitmentManager)
          .environmentObject(stompManager)
          .environmentObject(chattingManager)
      } else {
        AuthMainView()
          .environmentObject(authDataManager)
      }
    }
  }
}
