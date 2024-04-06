//
//  NightUserDetailView.swift
//  ZANI
//
//  Created by 정도현 on 4/7/24.
//

import SwiftUI

public struct NightUserDetailView: View {
  public var body: some View {
    VStack(spacing: 0) {
      Image("mateIcon")
        .padding(.bottom, 20)
      
      Text("사용자이름")
        .zaniFont(.title1)
        .foregroundStyle(.white)
        .padding(.bottom, 3)
      
      Text("잠만보")
        .zaniFont(.body2)
        .foregroundStyle(.green)
        .padding(.bottom, 14)
      
      followButton(isFollow: false)
      masterButton()
    }
    .frame(maxWidth: .infinity)
    .padding(.vertical, 20)
    .background(.main2)
    .clipShape(RoundedRectangle(cornerRadius: 20))
  }
}

extension NightUserDetailView {
  
  @ViewBuilder
  private func followButton(isFollow: Bool) -> some View {
    Button(action: {
      
    }, label: {
      Text(isFollow ? "팔로잉" : "팔로우")
        .zaniFont(.body2).bold()
        .foregroundStyle(isFollow ? .mainYellow : .main1)
        .padding(.horizontal, 20)
        .padding(.vertical, 8)
        .background(
          Capsule()
            .fill(isFollow ? .clear : .mainYellow)
            .overlay(
              Capsule()
                .stroke(.mainYellow)
            )
        )
    })   
  }
  
  @ViewBuilder
  private func masterButton() -> some View {
    Button(action: {
      
    }, label: {
      Text("추방하기")
        .zaniFont(.body2).bold()
        .foregroundStyle(.errorRed)
        .padding(.horizontal, 14)
        .padding(.vertical, 8)
        .background(
          Capsule()
            .stroke(.errorRed)
        )
    })
    .padding(.top, 8)
  }
}

#Preview {
  NightUserDetailView()
}
