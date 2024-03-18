//
//  CreateTeamView.swift
//  ZANI
//
//  Created by 정도현 on 3/15/24.
//

import SwiftUI

public struct CreateTeamView: View {
  @EnvironmentObject private var recruitmentPageManager: RecruitmentPageManager
  
  @State private var teamName: String = ""
  @State private var teamDescription: String = ""
  @State private var password: String = ""
  
  @State private var isSecretRoom: Bool = false
  
  public var body: some View {
    VStack(spacing: 0) {
      navigationBar()
      
      teamInfoSection()
      
      Spacer()
      
      bottomButton()
    }
    .navigationBarBackButtonHidden()
    .background(
      Color.zaniMain1
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
      isValid: true,
      action: {
        
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
      inputText: $teamName
    )
    .padding(.horizontal, 20)
  }
  
  @ViewBuilder
  private func sectionList() -> some View {
    VStack(spacing: 14) {
      ForEach(CreateTeamSection.allCases, id: \.title) { section in
        HStack {
          Text(section.title)
            .foregroundStyle(.white)
          
          Spacer()
          
          HStack(spacing: 4) {
            Text("\(section.title)을 선택해주세요")
            
            Image(systemName: "chevron.right")
              .resizable()
              .frame(width: 4, height: 8)
              .padding(.horizontal, 6)
              .padding(.vertical, 4)
          }
          .foregroundStyle(Color.zaniMain6)
        }
        .zaniFont(.body1)
        .padding(.vertical, 14)
        .padding(.leading, 16)
        .padding(.trailing, 14)
        .background(
          RoundedRectangle(cornerRadius: 10.0)
            .fill(Color(red: 35/255, green: 35/255, blue: 63/255))
        )
        .onTapGesture {
          recruitmentPageManager.push(.category(section))
        }
      }
    }
    .padding(.horizontal, 20)
  }
  
  @ViewBuilder
  private func secretRoomOption() -> some View {
    VStack(spacing: 7) {
      Toggle(isOn: $isSecretRoom, label: {
        Text("비밀방 여부")
          .foregroundStyle(.white)
      })
      .tint(Color.zaniMain2)
      .padding(.horizontal, 14)
      .padding(.vertical, 6)
      .background(
        RoundedRectangle(cornerRadius: 10.0)
          .fill(Color(red: 35/255, green: 35/255, blue: 63/255))
      )
      
      if isSecretRoom {
        ZaniTextField(
          placeholderText: "비밀번호 입력 (숫자 4자리 구성)",
          placeholderTextStyle: .body1,
          keyboardType: .numberPad,
          maximumInputCount: 4,
          inputText: $password
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
      inputText: $teamDescription
    )
    .padding(.horizontal, 20)
    .padding(.bottom, 40)
  }
}


#Preview {
  CreateTeamView()
    .environmentObject(RecruitmentPageManager())
}
