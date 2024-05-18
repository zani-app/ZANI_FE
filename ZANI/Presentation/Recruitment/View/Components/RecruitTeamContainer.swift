//
//  RecruitTeamContainer.swift
//  ZANI
//
//  Created by 정도현 on 3/29/24.
//

import SwiftUI

public struct RecruitTeamContainer: View {
  public var teamData: RecruitmentTeamData
  
  public init(teamData: RecruitmentTeamData) {
    self.teamData = teamData
  }
  
  public var body: some View {
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
  RecruitTeamContainer(
    teamData: RecruitmentTeamData(
      id: 1,
      title: "test",
      maxNum: 1,
      currentNum: 1,
      targetTime: 1,
      isSecret: false,
      password: "",
      category: "test",
      description: "test",
      createdAt: [1]
    )
  )
}
