//
//  NightMateListView.swift
//  ZANI
//
//  Created by 정도현 on 3/29/24.
//

import SwiftUI

public struct NightMateListView: View {
  @EnvironmentObject private var nightMateDataManager: NightMateDataManager
  
  @Binding var isTapUser: Bool
  
  public var body: some View {
    VStack(alignment: .leading, spacing: 0) {
      Text("밤샘메이트")
        .zaniFont(.title1)
        .foregroundStyle(.white)
        .padding(.bottom, 20)
      
      ScrollView {
        LazyVStack(spacing: 28) {
          mateInfo()
          mateInfo()
          mateInfo()
          mateInfo()
        }
        .padding(.top, 18)
      }
      
      HStack(spacing: 4) {
        Image("exitDoorIcon")
        
        Text("팀 나가기")
          .zaniFont(.title1)
          .foregroundStyle(.errorRed)
          .onTapGesture {
            nightMateDataManager.action(.tappedLeaveTeamIcon)
          }
      }
      .padding(.bottom, 26)
    }
    .padding(.top, 27)
    .padding(.horizontal, 16)
    .background(
      .main3
    )
  }
}

extension NightMateListView {
  
  @ViewBuilder
  private func mateInfo() -> some View {
    HStack(spacing: 12) {
      Image("mateIcon")
        .resizable()
        .frame(width: 40, height: 40)
        .overlay(
          Circle()
            .fill(.green)
            .frame(width: 10, height: 10)
            .overlay(
              Circle()
                .stroke(Color(red: 52/255, green: 62/255, blue: 70/255), lineWidth: 1)
            )
            .offset(x: 15, y: 14)
        )
      
      VStack(alignment: .leading, spacing: 4) {
        Text("사용자 이름")
          .zaniFont(.body2)
          .foregroundStyle(.white)
        
        Text("칭호")
          .zaniFont(.body2)
          .foregroundStyle(.green)
      }
      
      Spacer()
    }
    .background(.main3)
    .onTapGesture {
      isTapUser = true
    }
  }
}

#Preview {
  NightMateListView(isTapUser: .constant(false))
    .environmentObject(NightMateDataManager())
}
