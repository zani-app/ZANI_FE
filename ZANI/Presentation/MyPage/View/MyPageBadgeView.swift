//
//  MyPageBadgeView.swift
//  ZANI
//
//  Created by 정도현 on 4/8/24.
//

import SwiftUI

public struct MyPageBadgeView: View {
  @EnvironmentObject private var myPagePageManager: MyPagePageManager
  @EnvironmentObject private var myPageDataManager: MyPageDataManager
  
  public var body: some View {
    VStack(spacing: 0) {
      ZaniNavigationBar(
        title: "칭호 작세히 보기",
        leftAction: { myPagePageManager.pop() }
      )
      .padding(.bottom, 20)
      
      ScrollView(.vertical) {
        LazyVStack(spacing: 8) {
          ForEach(myPageDataManager.badgeList) { badgeData in
            BadgeContainer(badgeData: badgeData)
          }
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
    .environmentObject(MyPageDataManager())
}
