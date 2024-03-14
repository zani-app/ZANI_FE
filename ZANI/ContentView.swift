//
//  ContentView.swift
//  ZANI
//
//  Created by 정도현 on 3/14/24.
//

import SwiftUI

public struct ContentView: View {
  public var body: some View {
    VStack {
      TabView(
        selection: /*@START_MENU_TOKEN@*/.constant(1)/*@END_MENU_TOKEN@*/,
        
        content: {
          
          MateMain()
            .tabItem { Text("밤샘메이트") }.tag(1)
          
          RecruitmentMain()
            .tabItem { Text("모집페이지") }.tag(1)
          
          CommunityMain()
            .tabItem { Text("커뮤니티") }.tag(1)
          
          MyPageMain()
            .tabItem { Text("마이페이지") }.tag(1)
          
        }
      )
    }
    .padding()
  }
}

#Preview {
  ContentView()
}
