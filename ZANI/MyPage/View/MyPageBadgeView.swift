//
//  MyPageBadgeView.swift
//  ZANI
//
//  Created by 정도현 on 4/8/24.
//

import SwiftUI

public struct MyPageBadgeView: View {
  @EnvironmentObject private var myPagePageManager: MyPagePageManager
  
  let columns = [GridItem(.flexible(), spacing: 19), GridItem(.flexible())]
  
  public var body: some View {
    VStack(spacing: 0) {
      ZaniNavigationBar(title: "내가 획득한 칭호", leftAction: { myPagePageManager.pop() })
        .padding(.bottom, 21)
      
      ScrollView(.vertical) {
        LazyVGrid(columns: columns, spacing: 8) {
          badgeBox()
          badgeBox()
          badgeBox()
        }
        .padding(.horizontal, 20)
      }
    }
    .navigationBarBackButtonHidden()
    .background(
      .main1
    )
  }
}

extension MyPageBadgeView {
  
  @ViewBuilder
  private func badgeBox() -> some View {
    ZStack {
      RoundedRectangle(cornerRadius: 20)
        .fill(Color(red: 105/255, green: 105/255, blue: 143/255))
        .frame(maxWidth: .infinity)
        .frame(height: 188)
      
      VStack(spacing: 12) {
      Rectangle()
          .frame(width: 120, height: 120)
        
       Text("칭호이름")
          .zaniFont(.title1)
          .foregroundStyle(.white)
      }
    }
  }
}

#Preview {
  MyPageBadgeView()
    .environmentObject(MyPagePageManager())
}
