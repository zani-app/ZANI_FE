//
//  NightMissionView.swift
//  ZANI
//
//  Created by 정도현 on 4/7/24.
//

import SwiftUI

public struct NightMissionView: View {
  public var missionType: NightMissionType
  
  public init(missionType: NightMissionType) {
    self.missionType = missionType
  }
  
  public var body: some View {
    VStack(spacing: 0) {
      Text("생존신고 하기!")
        .zaniFont(.head1)
        .foregroundStyle(.white)
        .padding(.bottom, 12)
      
      missionType.missionImage
        .padding(.bottom, 20)
      
      Text(missionType.missionDescription)
        .zaniFont(.title1)
        .foregroundStyle(.white)
        .padding(.bottom, 20)
      
      Text("02:00:00")
        .font(.custom("Pretendard-Bold", size: 24))
        .foregroundStyle(.white)
        .padding(.bottom, 27)
      
      VStack(spacing: 10) {
        acceptButton()
        
        extendMinuteButton()
      }
    }
    .frame(maxWidth: .infinity)
    .padding(.vertical, 20)
    .background(.main2)
    .clipShape(RoundedRectangle(cornerRadius: 20))
  }
}

extension NightMissionView {
  
  @ViewBuilder
  private func acceptButton() -> some View {
    Text("수락하기")
      .zaniFont(.body2).bold()
      .foregroundStyle(.main1)
      .padding(.horizontal, 14)
      .padding(.vertical, 8)
      .background(
        Capsule()
          .fill(.mainYellow)
      )
  }
  
  @ViewBuilder
  private func extendMinuteButton() -> some View {
    Text("1분 보류하기")
      .zaniFont(.body2).bold()
      .foregroundStyle(.errorRed)
      .padding(.horizontal, 14)
      .padding(.vertical, 8)
      .background(
        Capsule()
          .stroke(Color.errorRed)
      )
  }
}

#Preview {
  NightMissionView(missionType: .balance)
}
