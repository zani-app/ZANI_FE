//
//  SectionListView.swift
//  ZANI
//
//  Created by 정도현 on 3/15/24.
//

import SwiftUI


public struct SectionListView: View {
  @EnvironmentObject private var recruitmentPageManager: RecruitmentPageManager
  
  public var section: CreateTeamSection
  
  public init(section: CreateTeamSection) {
    self.section = section
  }
  
  public var body: some View {
    VStack(spacing: 0) {
      navigationBar()
    
      VStack(spacing: 0) {
        ForEach(section.selectOptions.indices) { index in
          VStack(alignment: .leading, spacing: 0) {
            Text(section.selectOptions[index] + section.countUnit)
              .zaniFont(.body1)
              .foregroundStyle(.white)              
              .padding(.vertical, 16)
            
            Divider()
              .frame(height: 1)
              .overlay(Color.white.opacity(0.3))
              .opacity(index < section.selectOptions.count - 1 ? 1 : 0)
          }
        }
        .padding(.horizontal, 12)
      }
      .background(
        RoundedRectangle(cornerRadius: 10)
          .foregroundStyle(Color(red: 35/255, green: 35/255, blue: 63/255))
      )
      .padding(.horizontal, 20)
      .padding(.top, 30)
      
      Spacer()
      
    }
    .navigationBarBackButtonHidden()
    .background(
      Color.zaniMain1
    )
  }
}

extension SectionListView {
  
  @ViewBuilder
  private func navigationBar() -> some View {
    ZaniNavigationBar(
      title: section.title,
      leftAction: { recruitmentPageManager.pop() }
    )
  }
}

#Preview {
  SectionListView(section: .peopleCount)
    .environmentObject(RecruitmentPageManager())
}
