//
//  ContentView.swift
//  ZANI
//
//  Created by 정도현 on 3/14/24.
//

import SwiftUI

public struct ContentView: View {
  @StateObject private var recruitmentDataManager = RecruitmentDataManager()
  
  public var body: some View {
    TabView {
      Group {
        nightMainView()
        
        recruitmentMainView()
        
        communityMainView()
        
        mypageMainView()
      }
      .toolbarBackground(.main4, for: .tabBar)
    }
    .tint(.white)
    .onAppear {
      UITabBar.appearance().backgroundColor = .main4
    }
    .navigationBarBackButtonHidden()
  }
}

private extension ContentView {
  
  @ViewBuilder
  func nightMainView() -> some View {
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
  }
  
  @ViewBuilder
  private func recruitmentMainView() -> some View {
    RecruitmentMainView()
      .environmentObject(recruitmentDataManager)
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
  }
  
  @ViewBuilder
  private func communityMainView() -> some View {
    CommunityMainView()
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
  }
  
  @ViewBuilder
  private func mypageMainView() -> some View {
    MyPageMainView()
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
}

#Preview {
  ContentView()
}
