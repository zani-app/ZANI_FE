//
//  ContentView.swift
//  ZANI
//
//  Created by 정도현 on 3/14/24.
//

import SwiftUI

public struct ContentView: View {
  @EnvironmentObject private var recruitmentPageManager: RecruitmentPageManager
  @EnvironmentObject private var authPageManager: AuthPageManager

  public var body: some View {
    TabView(
      content: {
        MateMain()
          .tabItem { Text("밤샘메이트") }.tag(1)
        
        RecruitmentMain()
          .tabItem { Text("모집페이지") }.tag(2)
        
        CommunityMain()
          .tabItem { Text("커뮤니티") }.tag(3)
        
        MyPageMain()
          .tabItem { Text("마이페이지") }.tag(4)
        
      }
    )
    .navigationBarBackButtonHidden()
  }
}

#Preview {
  ContentView()
    .environmentObject(RecruitmentPageManager())
    .environmentObject(AuthPageManager())
}
