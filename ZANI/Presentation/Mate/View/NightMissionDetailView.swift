//
//  NightMissionDetailView.swift
//  ZANI
//
//  Created by 정도현 on 4/7/24.
//

import SwiftUI

public struct NightMissionDetailView: View {
  public var missionType: NightMissionType
  
  public init(missionType: NightMissionType) {
    self.missionType = missionType
  }
  
  public var body: some View {
    VStack(spacing: 0) {
      ZaniNavigationBar(title: "생존신고", leftAction: { })
        .padding(.bottom, 200)
      
      Text("mission Description")
        .zaniFont(.head1)
        .foregroundStyle(.white)
      
      if missionType == .takePicture {
        Button(action: {
          
        }, label: {
          HStack(spacing: 8) {
            Image("cameraIcon")
              .renderingMode(.template)
              .resizable()
              .frame(width: 20, height: 20)
              .foregroundStyle(.main1)
            
            Text("사진 추가하기")
          }
          .zaniFont(.title2)
          .foregroundStyle(.main1)
          .padding(16)
          .background(
            RoundedRectangle(cornerRadius: 20)
              .fill(.mainYellow)
          )
        })
        .padding(.top, 44)
      }
      
      Spacer()
      
      Text("00:34:12")
        .zaniFont(.head1)
        .foregroundStyle(.white)
        .padding(.bottom, 27)
    }
    .background(.main1)
  }
}

#Preview {
  NightMissionDetailView(missionType: .takePicture)
}
