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
  @StateObject private var authDataManager = AuthDataManager()
  
  @UIApplicationDelegateAdaptor var appDelegate: AppDelegate
  
  var body: some Scene {
    WindowGroup {
      if authDataManager.isLogin {
        ContentView()
      } else {
        AuthMainView()
          .environmentObject(authDataManager)
      }
    }
  }
}
