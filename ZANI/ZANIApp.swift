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
  @StateObject private var recruitmentManager = RecruitmentManager()
  @StateObject private var myPagePageManager = MyPagePageManager()
  @StateObject private var myPageManager = MyPageManager()
  
  @ObservedObject var stomp = StompClientManager()
  
  @UIApplicationDelegateAdaptor var appDelegate: AppDelegate
  
  @State private var showAuth: Bool = true

  var body: some Scene {
    WindowGroup {
      ContentView()
        .environmentObject(recruitmentPageManager)
        .environmentObject(recruitmentManager)
        .environmentObject(myPagePageManager)
        .environmentObject(myPageManager)
        .onAppear {
          stomp.setupWebSocket()
          stomp.sendMessage()
        }
//        .fullScreenCover(isPresented: $showAuth) {
//          AuthMainView()
//            .environmentObject(authPageManager)
//        }
//        .onChange(of: authPageManager.isDone) { newValue in
//          if newValue {
//            self.showAuth = false
//          }
//        }
    }
  }
}
