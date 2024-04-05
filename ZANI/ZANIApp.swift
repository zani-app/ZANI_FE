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
  @StateObject private var nightMatePageManager = NightMatePageManager()
  @StateObject private var recruitmentPageManager = RecruitmentPageManager()
  @StateObject private var communityPageManager = CommunityPageManager()
  @StateObject private var myPagePageManager = MyPagePageManager()
  
  @StateObject private var recruitmentManager = RecruitmentManager()
  @StateObject private var myPageManager = MyPageManager()
  @StateObject private var stompManager = StompClient()
  @StateObject private var chattingManager = ChattingManager()
  
  @UIApplicationDelegateAdaptor var appDelegate: AppDelegate
  
  @State private var showAuth: Bool = true

  var body: some Scene {
    WindowGroup {
      ContentView()
        .environmentObject(nightMatePageManager)
        .environmentObject(recruitmentPageManager)
        .environmentObject(communityPageManager)
        .environmentObject(myPagePageManager)
        .environmentObject(recruitmentManager)
        .environmentObject(myPageManager)
        .environmentObject(stompManager)
        .environmentObject(chattingManager)
        .fullScreenCover(isPresented: $showAuth) {
          AuthMainView()
            .environmentObject(authPageManager)
        }
        .onChange(of: authPageManager.isDone) { newValue in
          if newValue {
            self.showAuth = false
          }
        }
    }
  }
}
