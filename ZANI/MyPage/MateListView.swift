//
//  MateDetailView.swift
//  ZANI
//
//  Created by 정도현 on 3/20/24.
//

import SwiftUI

public struct MateListView: View {
  @EnvironmentObject private var myPagePageManager: MyPagePageManager
  
  public var body: some View {
    VStack(spacing: 0) {
      navigationBar()
      
      ScrollView {
        VStack(spacing: 24) {
          mateBox(name: "사용자 이름", badge: "잠만보")
          mateBox(name: "사용자 이름", badge: "잠만보")
          mateBox(name: "사용자 이름", badge: "잠만보")
          mateBox(name: "사용자 이름", badge: "잠만보")
          mateBox(name: "사용자 이름", badge: "잠만보")
        }
        .padding(.horizontal, 20)
        .padding(.bottom, 80)
      }
      .padding(.top, 25)
    }
    .navigationBarBackButtonHidden()
    .ignoresSafeArea(edges: .bottom)
    .background(
      Color.main1
    )
  }
}

extension MateListView {
  
  @ViewBuilder
  private func navigationBar() -> some View {
    ZaniNavigationBar(title: "나의 메이트", leftAction: { myPagePageManager.pop() })
  }
  
  @ViewBuilder
  private func mateBox(name: String, badge: String) -> some View {
    HStack(spacing: 12) {
      Image("profileIcon")
        .resizable()
        .frame(width: 40, height: 40)
      
      VStack(alignment: .leading, spacing: 0) {
        Text(name)
          .zaniFont(.body1)
          .foregroundStyle(.white)
        
        Spacer()
        
        Text(badge)
          .zaniFont(.body2)
          .foregroundStyle(.green)
      }
      
      Spacer()
    }
    .frame(height: 44)
    .background(
      Color.main1
    )
    .onTapGesture {
      myPagePageManager.push(.mateDetail)
    }
  }
}

#Preview {
  MateListView()
    .environmentObject(MyPagePageManager())
}
