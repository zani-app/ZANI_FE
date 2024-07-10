//
//  CreateTeamView.swift
//  ZANI
//
//  Created by 정도현 on 3/15/24.
//

import SwiftUI

public struct CreateTeamView: View {
  @EnvironmentObject private var recruitmentPageManager: RecruitmentPageManager
  @EnvironmentObject private var recruitmentDataManager: RecruitmentDataManager
  
  public var body: some View {
    VStack(spacing: 0) {
      navigationBar()
      
      teamInfoSection()
      
      Spacer()
      
      bottomButton()
    }
    .failureAlert(
      isAlert: $recruitmentDataManager.isAlertPresented,
      description: recruitmentDataManager.errorMsg,
      action: { recruitmentDataManager.viewState = .success }
    )
    .loadingView(isLoading: recruitmentDataManager.viewState == .loading)
    .onChange(of: recruitmentDataManager.viewState, perform: { newValue in
      if newValue == .success {
        recruitmentPageManager.pop()
      }
    })
    .navigationBarBackButtonHidden()
    .background(
      Color.main1
    )
  }
}

extension CreateTeamView {
  
  @ViewBuilder
  private func navigationBar() -> some View {
    ZaniNavigationBar(
      title: "팀 생성하기",
      leftAction: { recruitmentPageManager.pop() }
    )
    .padding(.bottom, 15)
  }
  
  @ViewBuilder
  private func teamInfoSection() -> some View {
    ScrollView {
      VStack(spacing: 30) {
        teamNameSection()
        
        sectionList()
        
        secretRoomOption()
        
        teamIntroduceSection()
      }
      .padding(.top, 15)
    }
  }
  
  @ViewBuilder
  private func bottomButton() -> some View {
    ZaniMainButton(
      title: "팀 생성하기",
      isValid: recruitmentDataManager.validateCreateTeamData(),
      action: {
        recruitmentDataManager.action(.tappedCreateTeam)
      }
    )
    .padding(.horizontal, 20)
    .padding(.bottom, 14)
  }
  
  @ViewBuilder
  private func teamNameSection() -> some View {
    ZaniTextField(
      placeholderText: "팀 이름을 입력해주세요",
      placeholderTextStyle: .title2,
      keyboardType: .default,
      maximumInputCount: 10,
      inputText: Binding(
        get: { recruitmentDataManager.createTeamData?.title ?? "" },
        set: { value in
          recruitmentDataManager.createTeamData?.title = value
        }
      )
    )
    .padding(.horizontal, 20)
  }
  
  @ViewBuilder
  private func sectionList() -> some View {
    if let data = recruitmentDataManager.createTeamData {
      VStack(spacing: 14) {
        sectionBox(section: .category, data: data.category)
        sectionBox(section: .peopleCount, data: data.maxNum == 0 ? "" : data.maxNum.description)
        sectionBox(section: .nightTime, data: data.targetTime == 0 ? "" : data.targetTime.description)
      }
      .padding(.horizontal, 20)
    } else {
      ProgressView()
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
  }
  
  @ViewBuilder
  private func sectionBox(section: CreateTeamSection, data: String) -> some View {
    HStack {
      Text(section.title)
        .foregroundStyle(.white)
      
      Spacer()
      
      HStack(spacing: 4) {
        Text("\(data.isEmpty ? "\(section.title)\(section == .category ? "를" : "을") 선택해주세요" : data + section.countUnit)")
        
        Image(systemName: "chevron.right")
          .resizable()
          .frame(width: 4, height: 8)
          .padding(.horizontal, 6)
          .padding(.vertical, 4)
      }
      .foregroundStyle(Color.mainGray)
    }
    .zaniFont(.body1)
    .padding(.vertical, 14)
    .padding(.leading, 16)
    .padding(.trailing, 14)
    .background(
      RoundedRectangle(cornerRadius: 10.0)
        .fill(Color.main2)
    )
    .onTapGesture {
      recruitmentPageManager.push(.category(section))
    }
  }
  
  @ViewBuilder
  private func secretRoomOption() -> some View {
    VStack(spacing: 7) {
      Toggle(
        isOn: Binding(
          get: { recruitmentDataManager.createTeamData?.secret ?? false },
          set: { value in
            recruitmentDataManager.createTeamData?.secret = value
          }
        ),
        label: {
          Text("비밀방 여부")
            .foregroundStyle(.white)
        })
      .tint(Color.mainYellow)
      .padding(.horizontal, 14)
      .padding(.vertical, 6)
      .background(
        RoundedRectangle(cornerRadius: 10.0)
          .fill(Color.main2)
      )
      
      if recruitmentDataManager.createTeamData?.secret ?? false {
        ZaniTextField(
          placeholderText: "비밀번호 입력 (숫자 4자리 구성)",
          placeholderTextStyle: .body1,
          keyboardType: .numberPad,
          maximumInputCount: 4,
          inputText: Binding(
            get: { recruitmentDataManager.createTeamData?.password ?? "" },
            set: { value in
              recruitmentDataManager.createTeamData?.password = value
            }
          )
        )
      }
    }
    .padding(.horizontal, 20)
  }
  
  @ViewBuilder
  private func teamIntroduceSection() -> some View {
    ZaniTextField(
      placeholderText: "팀을 소개할 문구를 작성해주세요. (구체적인 모집 대상, 목표 등)",
      placeholderTextStyle: .body1,
      keyboardType: .default,
      maximumInputCount: 50,
      lineLimit: 6,
      inputText: Binding(
        get: { recruitmentDataManager.createTeamData?.description ?? "" },
        set: { value in
          recruitmentDataManager.createTeamData?.description = value
        }
      )
    )
    .padding(.horizontal, 20)
    .padding(.bottom, 40)
  }
}

#Preview {
  CreateTeamView()
    .environmentObject(RecruitmentPageManager())
    .environmentObject(RecruitmentDataManager())
}
