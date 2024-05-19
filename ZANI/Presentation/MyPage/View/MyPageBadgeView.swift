//
//  MyPageBadgeView.swift
//  ZANI
//
//  Created by 정도현 on 4/8/24.
//

import SwiftUI

public struct MyPageBadgeView: View {
  @EnvironmentObject private var myPagePageManager: MyPagePageManager
  
  public var body: some View {
    VStack(spacing: 0) {
      ZaniNavigationBar(
        title: "칭호 작세히 보기",
        leftAction: { myPagePageManager.pop() }
      )
      .padding(.bottom, 20)
      
      ScrollView(.vertical) {
        LazyVStack(spacing: 8) {
          BadgeContainer(
            badgeData: BadgeDTO(title: "test", condition: "test", isLock: true)
          )
          
          BadgeContainer(
            badgeData: BadgeDTO(title: "test", condition: "test", isLock: true)
          )
          
          BadgeContainer(
            badgeData: BadgeDTO(title: "test", condition: "test", isLock: true)
          )
        }
      }
    }
    .navigationBarBackButtonHidden()
    .background(
      .main1
    )
  }
}

#Preview {
  MyPageBadgeView()
    .environmentObject(MyPagePageManager())
}
