//
//  RecruitmentMain.swift
//  ZANI
//
//  Created by 정도현 on 3/14/24.
//

import SwiftUI

public struct RecruitmentMain: View {
  @EnvironmentObject private var recruitmentPageManager: RecruitmentPageManager
  @EnvironmentObject private var recruitmentManager: RecruitmentManager
  
  @State private var isSearching: Bool = false
  
  @State private var selectedTeam: Team? = nil
  
  public var body: some View {
    NavigationStack(path: $recruitmentPageManager.route) {
      ZStack {
        VStack(spacing: 0) {
          title()
          
          filterList()
          
          searchBar()
          
          teamList()
        }
        
        if let selectedTeam = selectedTeam {
          TeamDetailView(teamInfo: $selectedTeam)
        }
      }
      .onAppear {
        recruitmentManager.requestTeamList()
        recruitmentManager.keyword = ""
      }
      .onChange(of: recruitmentManager.keyword, perform: { newValue in
        recruitmentManager.requestTeamList()
      })
      .navigationDestination(for: RecruitmentPageState.self) { pageState in
        recruitmentPageDestination(pageState)
      }
      .background(Color.main1)
    }
  }
}

extension RecruitmentMain {
  
  @ViewBuilder
  private func recruitmentPageDestination(_ type: RecruitmentPageState) -> some View {
    switch type {
    case .createTeam:
      CreateTeamView()
        .toolbar(.hidden, for: .tabBar)
      
    case let .category(category):
      SectionListView(section: category)
        .toolbar(.hidden, for: .tabBar)
      
    case .filter:
      FilterView(
        categoryBuffer: recruitmentManager.category,
        isSecretBuffer: recruitmentManager.isSecret,
        isEmptyBuffer: recruitmentManager.isEmpty
      )
      .toolbar(.hidden, for: .tabBar)
      
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
        action: {
          recruitmentPageManager.push(.createTeam)
          recruitmentManager.deInitCreateTeamData()
        }
      )
    }
    .padding(.top, 17)
    .padding(.horizontal, 20)
  }
  
  @ViewBuilder
  private func filterList() -> some View {
    ScrollView(.horizontal, showsIndicators: false) {
      HStack(spacing: 6) {
        Button(action: {
          withAnimation {
            self.isSearching.toggle()
          }
        }, label: {
          HStack(alignment: .center, spacing: 0) {
            Text("검색")
            
            Image("searchIcon")
              .renderingMode(.template)
              .padding(.leading, 4)
          }
          .foregroundStyle(self.isSearching ? Color.main1 : .white)
          .padding(.vertical, 6)
          .padding(.horizontal, 12)
          .zaniFont(.body2)
          .background(
            Capsule()
              .fill(self.isSearching ? Color.mainYellow : .clear)
              .overlay(
                Capsule()
                  .stroke(self.isSearching ? Color.mainYellow : .white)
              )
          )
        })
        
        ZaniCapsuleButton(
          title: "목표",
          isValid: false,
          trailingIcon: Image("chevronDown"),
          action: { recruitmentPageManager.push(.filter) }
        )
        ZaniCapsuleButton(
          title: "유형",
          isValid: !recruitmentManager.category.isEmpty,
          trailingIcon: Image("chevronDown"),
          action: { recruitmentPageManager.push(.filter) }
        )
        ZaniCapsuleButton(
          title: "빈 자리",
          isValid: recruitmentManager.isEmpty,
          action: { recruitmentPageManager.push(.filter) }
        )
        ZaniCapsuleButton(
          title: "비공개방",
          isValid: recruitmentManager.isSecret,
          action: { recruitmentPageManager.push(.filter) }
        )
      }
      .padding(1)
      .padding(.top, 16)
    }
    .padding(.horizontal, 20)
    .padding(.bottom, 12)
  }
  
  @ViewBuilder
  private func searchBar() -> some View {
    if self.isSearching {
      ZaniTextField(
        placeholderText: "방 검색하기",
        placeholderTextStyle: .body2,
        placeHolderColor: Color.main1,
        textColor: .black,
        backgroundColor: Color(red: 1, green: 234/255, blue: 184/255),
        keyboardType: .default,
        maximumInputCount: 20,
        inputText: $recruitmentManager.keyword
      )
      .padding(.horizontal, 20)
    }
  }
  
  @ViewBuilder
  private func teamList() -> some View {
    
    if let teamList = recruitmentManager.teamList {
      ScrollView {
        VStack(spacing: 10) {
          ForEach(teamList, id: \.id) { teamData in
            teamDisplayCapsule(teamData: teamData)
              .onTapGesture {
                self.selectedTeam = teamData
              }
          }
        }
        .padding(.horizontal, 20)
      }
      .padding(.top, 12)
    } else {
      Spacer()
      
      ProgressView()
      
      Spacer()
    }
  }
  
  @ViewBuilder
  private func teamDisplayCapsule(teamData: Team) -> some View {
    VStack(alignment: .leading, spacing: 33) {
      VStack(alignment: .leading, spacing: 10) {
        HStack(spacing: 4) {
          Text("모집 제목")
          
          if teamData.isSecret {
            Image("lockIcon")
          }
        }
        .zaniFont(.title2)
        .foregroundStyle(.white)
        
        Text(teamData.description)
          .zaniFont(.body2)
          .lineLimit(1)
          .foregroundStyle(.white)
      }
      
      HStack(spacing: 12) {
        HStack(spacing: 5){
          Text("밤샘시간")
            .zaniFont(.body2).bold()
          
          Text("\(teamData.targetTime)시간")
            .zaniFont(.body2)
        }
        
        HStack(spacing: 5){
          Text("카테고리")
            .zaniFont(.body2).bold()
          
          Text(teamData.category)
            .zaniFont(.body2)
        }
        
        HStack(spacing: 5){
          Text("인원")
            .zaniFont(.body2).bold()
          
          Text("\(teamData.currentNum) / \(teamData.maxNum)")
            .zaniFont(.body2)
        }
        
        Spacer()
      }
      .foregroundStyle(.main4)
    }
    .frame(maxWidth: .infinity)
    .padding(.horizontal, 16)
    .padding(.top, 12)
    .padding(.bottom, 14)
    .background(
      RoundedRectangle(cornerRadius: 20)
        .fill(Color.main2)
    )
  }
}

#Preview {
  RecruitmentMain()
    .environmentObject(RecruitmentPageManager())
    .environmentObject(RecruitmentManager())
}
