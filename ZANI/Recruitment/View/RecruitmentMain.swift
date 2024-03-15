//
//  RecruitmentMain.swift
//  ZANI
//
//  Created by 정도현 on 3/14/24.
//

import SwiftUI

public struct RecruitmentMain: View {
  @EnvironmentObject private var recruitmentPageManager: RecruitmentPageManager
  
  public var body: some View {
    NavigationStack(path: $recruitmentPageManager.route) {
      VStack(spacing: 0) {
        title()
        
        filterList()
        
        teamList()
      }
      .background(Color.main1)
      .navigationDestination(for: RecruitmentPageState.self) { pageState in
        recruitmentPageDestination(pageState)
      }
    }
  }
}

extension RecruitmentMain {
  
  @ViewBuilder
  private func recruitmentPageDestination(_ type: RecruitmentPageState) -> some View {
    switch type {
    case .createTeam:
      CreateTeamView()
      
    case let .category(category):
      SectionListView(section: category)
      
    default:
      RecruitmentMain()
    }
  }
  
  @ViewBuilder
  private func title() -> some View {
    HStack {
      Text("함께 할 밤샘 팀을 구해요!")
        .zaniFont(.title1)
        .foregroundStyle(.white)
      
      Spacer()
      
      ZaniCapsuleButton(
        title: "팀 생성하기",
        isValid: true,
        leadingIcon: Image("plusIcon"),
        horizontalPadding: 8,
        action: { recruitmentPageManager.push(.createTeam) }
      )
    }
    .padding(.top, 17)
    .padding(.horizontal, 20)
  }
  
  @ViewBuilder
  private func filterList() -> some View {
    ScrollView(.horizontal, showsIndicators: false) {
      HStack(spacing: 6) {
        ZaniCapsuleButton(
          title: "검색",
          isValid: false,
          trailingIcon: Image("searchIcon"),
          action: { }
        )
        ZaniCapsuleButton(
          title: "목표",
          isValid: false,
          trailingIcon: Image("chevronDown"),
          action: { }
        )
        ZaniCapsuleButton(
          title: "유형",
          isValid: false,
          trailingIcon: Image("chevronDown"),
          action: { }
        )
        ZaniCapsuleButton(
          title: "빈 자리",
          isValid: false,
          action: { }
        )
        ZaniCapsuleButton(
          title: "공개방",
          isValid: false,
          action: { }
        )
      }
      .padding(1)
      .padding(.top, 16)
    }
    .padding(.horizontal, 20)
    .padding(.bottom, 12)
  }
  
  @ViewBuilder
  private func teamList() -> some View {
    ScrollView {
      VStack(spacing: 10) {
        teamDisplayCapsule()
        teamDisplayCapsule()
        teamDisplayCapsule()
        teamDisplayCapsule()
        teamDisplayCapsule()
        teamDisplayCapsule()
      }
      .padding(.horizontal, 20)
    }
    .padding(.top, 12)
  }
  
  @ViewBuilder
  private func teamDisplayCapsule() -> some View {
    VStack(alignment: .leading, spacing: 33) {
      VStack(spacing: 9) {
        HStack {
          Text("모집 제목")
            .zaniFont(.title2)
        }
        .foregroundStyle(.white)
        
        Text("소개글~~")
          .zaniFont(.body2)
          .foregroundStyle(.white)
      }
      
      HStack(spacing: 12) {
        HStack(spacing: 5){
          Text("밤샘시간")
            .zaniFont(.body2).bold()
          
          
          Text("12시간")
            .zaniFont(.body2)
        }
        
        HStack(spacing: 5){
          Text("밤샘시간")
            .zaniFont(.body2).bold()
          
          
          Text("12시간")
            .zaniFont(.body2)
        }
        
        HStack(spacing: 5){
          Text("밤샘시간")
            .zaniFont(.body2).bold()
          
          
          Text("12시간")
            .zaniFont(.body2)
        }
        
        Spacer()
      }
      .foregroundStyle(.main6)
    }
    .frame(maxWidth: .infinity)
    .padding(.horizontal, 16)
    .padding(.top, 12)
    .padding(.bottom, 14)
    .background(
      RoundedRectangle(cornerRadius: 10)
        .fill(Color(red: 35/255, green: 35/255, blue: 63/255))
    )
  }
}

#Preview {
  RecruitmentMain()
    .environmentObject(RecruitmentPageManager())
}
