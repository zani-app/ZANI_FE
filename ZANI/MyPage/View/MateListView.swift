//
//  MateDetailView.swift
//  ZANI
//
//  Created by 정도현 on 3/20/24.
//

import SwiftUI

public struct MateListView: View {
  @EnvironmentObject private var myPagePageManager: MyPagePageManager
  @EnvironmentObject private var myPageManager: MyPageManager
  
  public var body: some View {
    VStack(spacing: 0) {
      navigationBar()
      
      if let followList = myPageManager.followList {
        ScrollView {
          VStack(spacing: 24) {
            ForEach(followList, id: \.self) { follow in
              mateBox(userInfo: follow)
            }
          }
          .padding(.horizontal, 20)
          .padding(.bottom, 80)
        }
        .padding(.top, 25)
      } else {
        ProgressView()
          .frame(maxWidth: .infinity, maxHeight: .infinity)
      }
    }
    .navigationBarBackButtonHidden()
    .ignoresSafeArea(edges: .bottom)
    .background(
      Color.main1
    )
    .onAppear {
      myPageManager.requestFollowList()
    }
  }
}

extension MateListView {
  
  @ViewBuilder
  private func navigationBar() -> some View {
    ZaniNavigationBar(title: "나의 메이트", leftAction: { myPagePageManager.pop() })
  }
  
  @ViewBuilder
  private func mateBox(userInfo: FollowDTO) -> some View {
    HStack(spacing: 12) {
      Image("profileIcon")
        .resizable()
        .frame(width: 40, height: 40)
      
      VStack(alignment: .leading, spacing: 0) {
        Text(userInfo.nickname)
          .zaniFont(.body1)
          .foregroundStyle(.white)
        
        Spacer()
        
        if let title = userInfo.title {
          Text(title)
            .zaniFont(.body2)
            .foregroundStyle(.green)
        }
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
    .environmentObject(MyPageManager())
}
