//
//  MyPageMainView.swift
//  ZANI
//
//  Created by 정도현 on 3/14/24.
//

import SwiftUI

public struct MyPageMainView: View {
  @StateObject private var myPagePageManager = MyPagePageManager()
  @StateObject private var myPageDataManager = MyPageDataManager()
  
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
      .onAppear {
        myPageDataManager.calendarDate = .now
        myPageDataManager.requestUserDetail()
        myPageDataManager.requestNightSummary()
        myPageDataManager.requestUserAchievement()
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

extension MyPageMainView {
  
  @ViewBuilder
  private func myPagePageDestination(_ type: MyPagePageState) -> some View {
    switch type {
    case .changeNickname:
      if let userInfo = myPageDataManager.userInfo {
        ChangeNicknameView(userName: userInfo.nickname)
          .toolbar(.hidden, for: .tabBar)
          .environmentObject(myPageDataManager)
          .environmentObject(myPagePageManager)
      }
      
    case .mateList:
      MateListView()
        .toolbar(.hidden, for: .tabBar)
        .environmentObject(myPageDataManager)
        .environmentObject(myPagePageManager)
      
    case .mateDetail:
      MateDetailView()
        .toolbar(.hidden, for: .tabBar)
        .environmentObject(myPageDataManager)
        .environmentObject(myPagePageManager)
      
    case .badgeDetail:
      MyPageBadgeView()
        .toolbar(.hidden, for: .tabBar)
        .environmentObject(myPageDataManager)
        .environmentObject(myPagePageManager)
      
    default:
      RecruitmentMainView()
    }
  }
  
  @ViewBuilder
  private func profileSection() -> some View {
    if let userInfo = myPageDataManager.userInfo {
      HStack(spacing: 10) {
        Group {
          if userInfo.profileImageUrl != "" {
            CachedImageView(url: userInfo.profileImageUrl, imageSize: 48)
          } else {
            Image("profileIcon")
              .resizable()
          }
        }
        .frame(width: 48, height: 48)
        .clipShape(
          Circle()
        )
        
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
        .environmentObject(myPageDataManager)
      
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
            if let allNightSummary = myPageDataManager.allNightSummary {
              Text("\(allNightSummary.totalAllNighters)회")
            } else {
              ProgressView()
                .frame(maxWidth: .infinity)
            }
          }
          .foregroundStyle(.mainYellow)
          
          Spacer()
        }
        
        HStack(spacing: 32) {
          Text("밤샘 누적 시간")
            .foregroundStyle(.white)
          
          Group {
            if let allNightSummary = myPageDataManager.allNightSummary {
              let convertedValue = myPageDataManager.convertSecondsToHoursMinutesSeconds(seconds: allNightSummary.totalDuration)
              
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
  }
  
  @ViewBuilder
  private func badgeSection() -> some View {
    VStack(alignment: .leading, spacing: 15) {
      HStack(spacing: 8) {
        Text("칭호 자세히 보기")
        
        Image(systemName: "chevron.right")
          .resizable()
          .frame(width: 6, height: 12)
          .padding(.horizontal, 9)
          .padding(.vertical, 6)
        
        Spacer()
      }
      .zaniFont(.title1)
      .foregroundStyle(.white)
      .background(.clear)
      .padding(.horizontal, 20)
      .onTapGesture {
        myPagePageManager.push(.badgeDetail)
      }
      
      if let badgeData = myPageDataManager.badgeList.first {
        BadgeContainer(
          badgeData: badgeData
        )
      }
    }
    .padding(.bottom, 40)
  }
}

#Preview {
  MyPageMainView()
}
