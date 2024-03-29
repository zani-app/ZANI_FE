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
  @EnvironmentObject private var myPagePageManager: MyPagePageManager
  
  public var body: some View {
    TabView {
      Group {
        NightMateMain()
          .tabItem {
            Label(
              title: { Text("밤샘메이트") },
              icon: {
                Image("MateIcon")
                  .renderingMode(.template)
              }
            )
          }
          .tag(1)
        
        RecruitmentMain()
          .tabItem {
            Label(
              title: { Text("모집페이지") },
              icon: {
                Image("RecruitIcon")
                  .renderingMode(.template)
              }
            )
          }
          .tag(2)
        
        CommunityMain()
          .tabItem {
            Label(
              title: { Text("커뮤니티") },
              icon: {
                Image("CommunityIcon")
                  .renderingMode(.template)
              }
            )
          }
          .tag(3)
        
        MyPageMain()
          .tabItem {
            Label(
              title: { Text("마이페이지") },
              icon: {
                Image("MyPageIcon")
                  .renderingMode(.template)
              }
            )
          }
          .tag(4)
      }
      .toolbarBackground(.main4, for: .tabBar)
    }
    .tint(.white)
    .navigationBarBackButtonHidden()
  }
}

#Preview {
  ContentView()
    .environmentObject(RecruitmentPageManager())
    .environmentObject(AuthPageManager())
    .environmentObject(MyPagePageManager())
}
