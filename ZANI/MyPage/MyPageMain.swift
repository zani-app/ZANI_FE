//
//  MyPageMain.swift
//  ZANI
//
//  Created by 정도현 on 3/14/24.
//

import SwiftUI

public struct MyPageMain: View {
  @EnvironmentObject private var myPagePageManager: MyPagePageManager
  
  public var body: some View {
    NavigationStack(path: $myPagePageManager.route) {
      ScrollView(.vertical, showsIndicators: false) {
        VStack(spacing: 60) {
          profileSection()
          calendarSection()
          staticticSection()
          badgeSection()
        }
      }
      .navigationDestination(for: MyPagePageState.self) { pageState in
        myPagePageDestination(pageState)
      }
      .background(
        LinearGradient(
          colors: [
            .main1,
            .main4
          ],
          startPoint: .top,
          endPoint: .bottom
        )
      )
    }
  }
}

extension MyPageMain {
  
  @ViewBuilder
  private func myPagePageDestination(_ type: MyPagePageState) -> some View {
    switch type {
    case .changeNickname:
      ChangeNicknameView(userName: "test")
      
    case .mateList:
      MateListView()
      
    case .mateDetail:
      MateDetailView()
      
    default:
      RecruitmentMain()
    }
  }
  
  @ViewBuilder
  private func profileSection() -> some View {
    HStack(spacing: 10) {
      Image("profileIcon")
      
      VStack(alignment: .leading, spacing: 10) {
        HStack(spacing: 7) {
          Text("유저 이름")
            .zaniFont(.body1)
            .bold()
            .foregroundStyle(.white)
          
          Text("칭호 이름")
            .foregroundStyle(.white)
        }
        
        HStack(spacing: 12) {
          Text("나의 메이트 보기")
          Image(systemName: "chevron.right")
            .bold()
        }
        .zaniFont(.body1)
        .background(
          Color.main1
        )
        .onTapGesture {
          myPagePageManager.push(.mateList)
        }
        .foregroundStyle(.white)
      }
      
      Spacer()
      
      Image("pencilIcon")
        .onTapGesture {
          myPagePageManager.push(.changeNickname)
        }
    }
    .padding(.top, 33)
    .padding(.horizontal, 20)
  }
  
  @ViewBuilder
  private func calendarSection() -> some View {
    VStack(alignment: .leading, spacing: 15) {
      Text("나의 밤샘 달력")
        .zaniFont(.title1)
        .foregroundStyle(.white)
      
      MyPageCalendarView()
      
      HStack(spacing: 8) {
        ForEach(MoonLevel.allCases, id: \.self) { level in
          HStack(spacing: 8) {
            level.moonImage
              .resizable()
              .frame(width: 14, height: 14)
            
            Text(level.description)
              .zaniFont(.body2)
              .foregroundStyle(.white)
          }
        }
      }
      .padding(.horizontal, 14)
    }
    .padding(.horizontal, 20)
  }
  
  @ViewBuilder
  private func staticticSection() -> some View {
    VStack(alignment: .leading, spacing: 15) {
      Text("내 밤샘 기록 통계")
        .zaniFont(.title1)
        .foregroundStyle(.white)
      
      VStack(alignment: .leading, spacing: 24) {
        HStack(spacing: 32) {
          Text("밤샘 횟수")
            .foregroundStyle(.white)
          
          Text("8회")
            .foregroundStyle(.main2)
          
          Spacer()
        }
        
        HStack(spacing: 32) {
          Text("밤샘 누적 시간")
            .foregroundStyle(.white)
          
          Text("56:07:07")
            .foregroundStyle(.main2)
          
          Spacer()
        }
      }
      .zaniFont(.title1)
      .padding(.leading, 20)
      .padding(.top, 27)
      .padding(.bottom, 35)
      .background(
        RoundedRectangle(cornerRadius: 20)
          .fill(.main7)
          .frame(maxWidth: .infinity)
      )
    }
    .padding(.horizontal, 20)
  }
  
  @ViewBuilder
  private func badgeSection() -> some View {
    VStack(alignment: .leading, spacing: 20) {
      HStack(spacing: 8) {
        Text("내가 획득한 칭호")
        Image(systemName: "chevron.right")
      }
      .zaniFont(.title1)
      .foregroundStyle(.white)
      .padding(.horizontal, 20)
      
      ScrollView(.horizontal, showsIndicators: false) {
        HStack(spacing: 14) {
          Text("잠만보")
            .zaniFont(.title1)
            .foregroundStyle(.white)
            .padding(.top, 159)
            .padding(.bottom, 24)
            .padding(.horizontal, 65)
            .background(
              RoundedRectangle(cornerRadius: 30)
                .fill(Color(red: 105/255, green: 105/255, blue: 143/255))
            )
          
          Text("잠만보")
            .zaniFont(.title1)
            .foregroundStyle(.white)
            .padding(.top, 159)
            .padding(.bottom, 24)
            .padding(.horizontal, 65)
            .background(
              RoundedRectangle(cornerRadius: 30)
                .fill(Color(red: 105/255, green: 105/255, blue: 143/255))
            )
          
          Text("잠만보")
            .zaniFont(.title1)
            .foregroundStyle(.white)
            .padding(.top, 159)
            .padding(.bottom, 24)
            .padding(.horizontal, 65)
            .background(
              RoundedRectangle(cornerRadius: 30)
                .fill(Color(red: 105/255, green: 105/255, blue: 143/255))
            )
        }
        .padding(.horizontal, 20)
      }
    }
    .padding(.bottom, 40)
  }
}

#Preview {
  MyPageMain()
    .environmentObject(MyPagePageManager())
}
