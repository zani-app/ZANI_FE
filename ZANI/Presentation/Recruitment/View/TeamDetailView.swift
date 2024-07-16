//
//  TeamDetailView.swift
//  ZANI
//
//  Created by 정도현 on 3/22/24.
//

import SwiftUI

public struct TeamDetailView: View {
  @EnvironmentObject private var recruitmentDataManager: RecruitmentDataManager
  
  public var body: some View {
    ZStack {
      Color.black.opacity(0.7).ignoresSafeArea()
        .onTapGesture {
          recruitmentDataManager.action(.tappedOutsideTeamDetailView)
        }
      
      if let teamInfo = recruitmentDataManager.selectedTeam {
        contents(teamInfo: teamInfo)
      } else {
        Text("Data Error")
      }
    }
    .onChange(of: recruitmentDataManager.viewState) { newValue in
      if newValue == .success {
        recruitmentDataManager.action(.tappedOutsideTeamDetailView)
      }
    }
  }
}

extension TeamDetailView {
  
  @ViewBuilder
  private func contents(teamInfo: RecruitmentTeamData) -> some View {
    VStack(spacing: 0) {
      VStack(alignment: .leading, spacing: 0) {
        HStack(spacing: 4) {
          Text(teamInfo.title)
          
          if teamInfo.isSecret {
            Image("lockIcon")
          }
        }
        .zaniFont(.title2)
        .foregroundStyle(.white)
        .padding(.bottom, 13)
        
        HStack(spacing: 12) {
          detailList(title: "밤샘시간", content: "\(teamInfo.targetTime)시간")
          detailList(title: "카테고리", content: "\(teamInfo.category)")
          detailList(title: "인원", content: "\(teamInfo.currentNum) / \(teamInfo.maxNum)")
        }
        .padding(.bottom, 24)
        
        Text(teamInfo.description)
          .zaniFont(.body2)
          .foregroundStyle(.white)
      }
      
      Spacer()
      
      bottomButton()
    }
    .frame(height: 262)
    .padding(20)
    .background(
      RoundedRectangle(cornerRadius: 20)
        .foregroundStyle(Color.main4)
    )
  }
  
  @ViewBuilder
  private func bottomButton() -> some View {
    Button(action: {
      recruitmentDataManager.action(.tappedApplyTeam)
    }, label: {
      Text("팀 가입하기")
        .zaniFont(.body2).bold()
        .foregroundColor(.main1)
        .padding(.vertical, 10)
        .padding(.horizontal, 16)
        .background(
          Capsule()
            .fill(.mainYellow)
        )
    })
  }
  
  @ViewBuilder
  private func detailList(title: String, content: String) -> some View {
    HStack(spacing: 5) {
      Text(title)
        .zaniFont(.body2).bold()
      Text(content)
        .zaniFont(.body2)
    }
    .foregroundStyle(Color.mainGray)
  }
}

#Preview {
  TeamDetailView()
    .environmentObject(RecruitmentDataManager())
}
