//
//  SectionListView.swift
//  ZANI
//
//  Created by 정도현 on 3/15/24.
//

import SwiftUI


public struct SectionListView: View {
  @EnvironmentObject private var recruitmentPageManager: RecruitmentPageManager
  @EnvironmentObject private var recruitmentManager: RecruitmentManager
  
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
            HStack {
              Text(section.selectOptions[index] + section.countUnit)
                .zaniFont(.body1)
                .foregroundStyle(.white)
                .padding(.vertical, 16)
              
              Spacer()
              
              switch self.section {
              case .category:
                if recruitmentManager.teamCategory == section.selectOptions[index] {
                  Image("textfieldCheck")
                }
              case .peopleCount:
                if recruitmentManager.maxNum == Int(section.selectOptions[index]) {
                  Image("textfieldCheck")
                }
                
              case .nightTime:
                if recruitmentManager.targetTime == Int(section.selectOptions[index]) {
                  Image("textfieldCheck")
                }
              }
            }
            .padding(.trailing, 4)
            
            Divider()
              .frame(height: 1)
              .overlay(Color.white.opacity(0.3))
              .opacity(index < section.selectOptions.count - 1 ? 1 : 0)
          }
          .background(
            Color.main2
          )
          .onTapGesture {
            switch self.section {
            case .category:
              recruitmentManager.teamCategory = section.selectOptions[index]
            case .peopleCount:
              recruitmentManager.maxNum = Int(section.selectOptions[index])
            case .nightTime:
              recruitmentManager.targetTime = Int(section.selectOptions[index])
            }
          }
        }
      }
      .padding(.horizontal, 12)
      .background(
        RoundedRectangle(cornerRadius: 10)
          .foregroundStyle(Color.main2)
      )
      .padding(.horizontal, 20)
      .padding(.top, 30)
      
      Spacer()
      
    }
    .navigationBarBackButtonHidden()
    .background(
      Color.main1
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
    .environmentObject(RecruitmentManager())
}
