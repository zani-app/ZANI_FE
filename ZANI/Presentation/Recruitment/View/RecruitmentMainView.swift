//
//  RecruitmentMainView.swift
//  ZANI
//
//  Created by 정도현 on 3/14/24.
//

import SwiftUI

public struct RecruitmentMainView: View {
  @StateObject private var recruitmentPageManager = RecruitmentPageManager()
  @StateObject private var recruitmentDataManager = RecruitmentDataManager()
  
  @State private var isSearching: Bool = false
  @State private var selectedTeam: RecruitmentTeamData? = nil
  
  public var body: some View {
    NavigationStack(path: $recruitmentPageManager.route) {
      ZStack {
        VStack(spacing: 0) {
          title()
          
          filterList()
          
          searchBar()
          
          teamList()
        }
        
        if selectedTeam != nil {
          TeamDetailView(teamInfo: $selectedTeam)
        }
      }
      .task {
        recruitmentDataManager.requestTeamList()
      }
      .onAppear {
        recruitmentDataManager.deInitCreateTeamData()
        recruitmentDataManager.requestTeamData.keyword = ""
      }
      .onChange(of: recruitmentDataManager.requestTeamData.keyword, perform: { newValue in
        recruitmentDataManager.requestTeamList()
      })
      .navigationDestination(for: RecruitmentPageState.self) { pageState in
        recruitmentPageDestination(pageState)
      }
      .background(Color.main1)
    }
  }
}

extension RecruitmentMainView {
  
  @ViewBuilder
  private func recruitmentPageDestination(_ type: RecruitmentPageState) -> some View {
    switch type {
    case .createTeam:
      CreateTeamView()
        .toolbar(.hidden, for: .tabBar)
        .environmentObject(recruitmentDataManager)
        .environmentObject(recruitmentPageManager)
      
    case let .category(category):
      SectionListView(section: category)
        .toolbar(.hidden, for: .tabBar)
        .environmentObject(recruitmentDataManager)
        .environmentObject(recruitmentPageManager)
      
    case .filter:
      FilterView(
        categoryBuffer: recruitmentDataManager.requestTeamData.category,
        isSecretBuffer: recruitmentDataManager.requestTeamData.isSecret,
        isEmptyBuffer: recruitmentDataManager.requestTeamData.isEmpty
      )
      .toolbar(.hidden, for: .tabBar)
      .environmentObject(recruitmentDataManager)
      .environmentObject(recruitmentPageManager)
      
    default:
      RecruitmentMainView()
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
          recruitmentDataManager.allocCreateTeamData()
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
          isValid: !recruitmentDataManager.requestTeamData.category.isEmpty,
          trailingIcon: Image("chevronDown"),
          action: { recruitmentPageManager.push(.filter) }
        )
        ZaniCapsuleButton(
          title: "빈 자리",
          isValid: recruitmentDataManager.requestTeamData.isEmpty,
          action: { recruitmentPageManager.push(.filter) }
        )
        ZaniCapsuleButton(
          title: "비공개방",
          isValid: recruitmentDataManager.requestTeamData.isSecret,
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
        inputText: $recruitmentDataManager.requestTeamData.keyword
      )
      .padding(.horizontal, 20)
    }
  }
  
  @ViewBuilder
  private func teamList() -> some View {
    
    if let teamList = recruitmentDataManager.teamList {
      ScrollView {
        VStack(spacing: 10) {
          ForEach(teamList, id: \.id) { teamData in
            RecruitTeamContainer(teamData: teamData)
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
}

#Preview {
  RecruitmentMainView()
}