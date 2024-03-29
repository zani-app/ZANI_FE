//
//  NightTimeLineView.swift
//  ZANI
//
//  Created by 정도현 on 3/29/24.
//

import SwiftUI

public struct NightTimeLineView: View {
  @EnvironmentObject private var nightMatePageManager: NightMatePageManager
  
  @State private var selectedMission: String? = nil
  @State private var isShowMission: Bool = false
  
  public var body: some View {
    VStack(spacing: 0) {
      ZaniNavigationBar(title: "타임라인", leftAction: { nightMatePageManager.pop() })
      
      ScrollView {
        LazyVStack(spacing: 39) {
          missionContent()
          missionContent()
          missionContent()
          missionContent()
        }
        .padding(.top, 24)
        .padding(.horizontal, 20)
      }
      
      Spacer()
    }
    .sheet(isPresented: $isShowMission, content: {
      missionDetailSheet() 
        .presentationDetents([.fraction(0.82)])
        .presentationDragIndicator(.visible)
    })
    .background(
      Color.main1
    )
    .navigationBarBackButtonHidden()
  }
}

extension NightTimeLineView {
  
  @ViewBuilder
  private func missionDetailSheet() -> some View {
    VStack(spacing: 32) {
      Group {
        Text("밸런스게임 미션")
          .foregroundStyle(.white)
        
        Text("밥 맛 똥먹기 VS 똥 맛 밥먹기")
          .foregroundStyle(.mainYellow)
      }
      .zaniFont(.title1)
      
      ScrollView {
        VStack(spacing: 10) {
          mateMissionCaption()
          mateMissionCaption()
        }
      }
    }
    .padding(.top, 44)
    .padding(.horizontal, 20)
    .background(
      Color.main2
    )
  }
  
  @ViewBuilder
  private func mateMissionCaption() -> some View {
    HStack(spacing: 10) {
      Image("profileIcon")
        .resizable()
        .frame(width: 40, height: 40)
      
      VStack(alignment: .leading, spacing: 6) {
        Text("사용자 이름")
          .zaniFont(.body2).bold()
        
        Text("밥 맛 똥먹기")
          .zaniFont(.body2)
      }
      .foregroundStyle(.white)
      
      Spacer()
    }
    .padding(.vertical, 10)
  }
  
  @ViewBuilder
  private func missionContent() -> some View {
    HStack(alignment: .top, spacing: 16) {
      HStack(spacing: 16) {
        Text("22:30")
          .zaniFont(.title2)
          .foregroundStyle(.main1)
          .padding(.horizontal, 6)
          .padding(.vertical, 5)
          .background(
            RoundedRectangle(cornerRadius: 10)
              .fill(.mainYellow)
          )
        
        Image("timelineDot")
      }
      
      Text("미션 종류")
        .zaniFont(.body2).bold()
        .foregroundStyle(.white)
        .padding(16)
        .background(
          RoundedRectangle(cornerRadius: 20)
            .fill(.main2)
        )
        .onTapGesture {
          self.isShowMission = true
        }
      
      Spacer()
    }
  }
}

#Preview {
  NightTimeLineView()
    .environmentObject(NightMatePageManager())
}
