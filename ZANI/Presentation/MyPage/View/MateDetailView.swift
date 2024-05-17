//
//  MateDetailView.swift
//  ZANI
//
//  Created by 정도현 on 3/20/24.
//

import SwiftUI

public struct MateDetailView: View {
  @EnvironmentObject private var myPagePageManager: MyPagePageManager
  
  public var body: some View {
    VStack(spacing: 0) {
      navigationBar()
      
      ScrollView {
        VStack(spacing: 44) {
          mateInfo()
          
          mateCalendar()
          
          mateNightStatistics()
        }
      }
      
      Spacer()
    }
    .ignoresSafeArea(edges: .bottom)
    .navigationBarBackButtonHidden()
    .background(
      Color.main1
    )
  }
}

extension MateDetailView {
  
  @ViewBuilder
  private func navigationBar() -> some View {
    ZaniNavigationBar(title: "사용자 이름", leftAction: { myPagePageManager.pop() })
  }
  
  @ViewBuilder
  private func mateInfo() -> some View {
    HStack(alignment: .top, spacing: 10) {
      Image("profileIcon")
        .resizable()
        .frame(width: 48, height: 48)
      
      HStack(spacing: 7) {
        Text("유저이름")
          .foregroundStyle(.white)
          .zaniFont(.body3)
        
        Text("잠만보")
          .zaniFont(.body2)
          .padding(.vertical, 1)
          .padding(.horizontal, 8)
          .background(
            Capsule()
              .fill(.green)
          )
      }
      .padding(.top, 9)
      
      Spacer()
    }
    .padding(.top, 26)
    .padding(.horizontal, 20)
  }
  
  @ViewBuilder
  private func mateCalendar() -> some View {
    VStack(alignment: .leading, spacing: 20) {
      Text("팔로워의 밤샘 달력")
        .zaniFont(.title1)
        .foregroundStyle(.white)
      
      MyPageCalendarView()
    }
    .padding(.horizontal, 20)
  }
  
  @ViewBuilder
  private func mateNightStatistics() -> some View {
    VStack(alignment: .leading, spacing: 15) {
      Text("팔로워의 밤샘 기록 통계")
        .zaniFont(.title1)
        .foregroundStyle(.white)
      
      VStack(alignment: .leading, spacing: 24) {
        HStack(spacing: 32) {
          Text("밤샘 횟수")
            .foregroundStyle(.white)
          
          Text("8회")
            .foregroundStyle(.mainYellow)
          
          Spacer()
        }
        
        HStack(spacing: 32) {
          Text("밤샘 누적 시간")
            .foregroundStyle(.white)
          
          Text("56:07:07")
            .foregroundStyle(.mainYellow)
          
          Spacer()
        }
      }
      .zaniFont(.title1)
      .padding(.leading, 20)
      .padding(.top, 27)
      .padding(.bottom, 35)
      .background(
        RoundedRectangle(cornerRadius: 20)
          .fill(.main2)
          .frame(maxWidth: .infinity)
      )
    }
    .padding(.horizontal, 20)
    .padding(.bottom, 80)
  }
}

#Preview {
  MateDetailView()
    .environmentObject(MyPagePageManager())
}
