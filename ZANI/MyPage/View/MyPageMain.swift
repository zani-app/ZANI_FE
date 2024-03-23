//
//  MyPageMain.swift
//  ZANI
//
//  Created by 정도현 on 3/14/24.
//

import SwiftUI

public struct MyPageMain: View {
  @EnvironmentObject private var myPagePageManager: MyPagePageManager
  @EnvironmentObject private var myPageManager: MyPageManager
  
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
    .onAppear {
      myPageManager.calendarDate = .now
      myPageManager.requestUserDetail()
      myPageManager.requestNightSummary()
    }
  }
}

extension MyPageMain {
  
  @ViewBuilder
  private func myPagePageDestination(_ type: MyPagePageState) -> some View {
    switch type {
    case .changeNickname:
      if let userInfo = myPageManager.userInfo {
        ChangeNicknameView(userName: userInfo.nickname)
          .toolbar(.hidden, for: .tabBar)
      }
      
    case .mateList:
      MateListView()
        .toolbar(.hidden, for: .tabBar)
      
    case .mateDetail:
      MateDetailView()
        .toolbar(.hidden, for: .tabBar)
      
    default:
      RecruitmentMain()
    }
  }
  
  @ViewBuilder
  private func profileSection() -> some View {
    if let userInfo = myPageManager.userInfo {
      HStack(spacing: 10) {
        Image("profileIcon")
        
        VStack(alignment: .leading, spacing: 10) {
          HStack(spacing: 7) {
            Text(userInfo.nickname)
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
    } else {
      ProgressView()
        .padding(.top, 33)
        .padding(.horizontal, 20)
    }
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
          
          Group {
            if let allNightSummary = myPageManager.allNightSummary {
              Text("\(allNightSummary.totalAllNighters)회")
            } else {
              ProgressView()
                .frame(maxWidth: .infinity)
            }
          }
          .foregroundStyle(.main2)
          
          Spacer()
        }
        
        HStack(spacing: 32) {
          Text("밤샘 누적 시간")
            .foregroundStyle(.white)
          
          Group {
            if let allNightSummary = myPageManager.allNightSummary {
              let convertedValue = myPageManager.convertSecondsToHoursMinutesSeconds(seconds: allNightSummary.totalDuration)
              
              Text(
                String(
                  format: "%02d : %02d : %02d",
                  convertedValue.hours,
                  convertedValue.minutes,
                  convertedValue.seconds
                )
              )
            } else {
              ProgressView()         
                .frame(maxWidth: .infinity)
            }
          }
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
    .environmentObject(MyPageManager())
}
