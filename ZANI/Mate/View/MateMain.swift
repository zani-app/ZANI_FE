//
//  MateMain.swift
//  ZANI
//
//  Created by 정도현 on 3/29/24.
//

import SwiftUI

public struct MateMain: View {
  public var body: some View {
    ScrollView {
      LazyVStack(alignment: .leading, spacing: 0) {
        enterTeamButton()
        
        teamRecommendSection()
        
        hotBoardList()
      }
    }
    .background(
      Color.main1
    )
  }
}

extension MateMain {
  
  @ViewBuilder
  private func enterTeamButton() -> some View {
    VStack(alignment: .leading, spacing: 0) {
      Group {
        Text("밤샘 메이트들과 함께 밤샘해요!")
        Text("참여하기 버튼을 누르면 팀페이지로 이동합니다")
      }
      .zaniFont(.body1)
      .foregroundStyle(.white)
      
      Spacer()
      
      HStack {
        Spacer()
        
        Button(action: {
          
        }, label: {
          Text("밤샘 참여하기")
            .zaniFont(.body2)
            .foregroundStyle(.main1)
            .padding(.vertical, 8)
            .padding(.horizontal, 15)
            .background(
              Capsule()
                .fill(.mainYellow)
            )
        })
      }
    }
    .padding(.top, 40)
    .padding(.horizontal, 16)
    .padding(.bottom, 17)
    .background(
      ZStack {
        LinearGradient(
          colors: [
            Color(red: 47/255, green: 33/255, blue: 103/255),
            Color(red: 37/255, green: 31/255, blue: 97/255)
          ],
          startPoint: .bottomLeading,
          endPoint: .topTrailing
        )
        
        Image("buttonCloud")
      }
    )
    .frame(height: 234)
    .clipShape(
      RoundedRectangle(cornerRadius: 20)
    )
    .padding(.horizontal, 20)
    .padding(.vertical, 41)
  }
  
  @ViewBuilder
  private func teamRecommendSection() -> some View {
    VStack(alignment: .leading, spacing: 0) {
      Text("이런 밤샘 팀은 어때요?")
        .zaniFont(.title1)
        .foregroundStyle(.white)
        .padding(.bottom, 16)
      
      VStack(spacing: 10) {
        ForEach(0..<3) { _ in
          RecruitTeamCapsule(teamData: RecruitmentTeamData(id: 1, title: "test", maxNum: 1, currentNum: 1, targetTime: 1, isSecret: true, password: "test", category: "Test", description: "test", createdAt: [1]))
        }
      }
      
    }
    .padding(.horizontal, 20)
    .padding(.bottom, 52)
  }
  
  @ViewBuilder
  private func hotBoardList() -> some View {
    VStack(alignment: .leading, spacing: 0) {
      Text("지금 인기 있는 밤샘 꿀팁 게시글!")
        .zaniFont(.title1)
        .foregroundStyle(.white)
        .padding(.leading, 20)
        .padding(.bottom, 16)
      
      divider()
      
      VStack(alignment: .leading, spacing: 8) {
        HStack(spacing: 0) {
          VStack(alignment: .leading, spacing: 16) {
            Text("게시글 제목")
              .zaniFont(.title2)
            
            Text("게시글 컨텐츠")
              .zaniFont(.body2)
          }
          .foregroundStyle(.white)
          
          Spacer()
          
          RoundedRectangle(cornerRadius: 10)
            .frame(width: 64, height: 64)
            .foregroundStyle(.black)
        }
        
        Text("50")
          .foregroundStyle(Color.mainGray)
      }
      .padding(20)
    }
  }
  
  @ViewBuilder
  private func divider() -> some View {
    Divider()
      .frame(height: 2)
      .overlay(Color.main4)
  }
}

#Preview {
  MateMain()
}
