//
//  CommunityMain.swift
//  ZANI
//
//  Created by 정도현 on 3/14/24.
//

import SwiftUI

public struct CommunityMain: View {
  @EnvironmentObject private var communityPageManager: CommunityPageManager
  
  public var body: some View {
    NavigationStack(path: $communityPageManager.route) {
      ZStack {
        ScrollView {
          LazyVStack(spacing: 0) {
            title()
            
            VStack(spacing: 0) {
              divider()
              CommunityBoardBox()
                .onTapGesture {
                  communityPageManager.push(.detail)
                }
              divider()
              CommunityBoardBox()
                .onTapGesture {
                  communityPageManager.push(.detail)
                }
              divider()
              CommunityBoardBox()
                .onTapGesture {
                  communityPageManager.push(.detail)
                }
              divider()
              CommunityBoardBox()
                .onTapGesture {
                  communityPageManager.push(.detail)
                }
              divider()
            }
            
          }
        }
        .padding(.top, 10)
        
        writeButton()
      }
      .background(
        Color.main1
      )
      .navigationDestination(for: CommunityPageState.self) { pageState in
        communityPageDestination(pageState)
      }
    }
  }
}

extension CommunityMain {
  
  @ViewBuilder
  private func communityPageDestination(_ type: CommunityPageState) -> some View {
    switch type {
    case .writing:
      CommunityWritingView()
        .toolbar(.hidden, for: .tabBar)
      
    case .detail:
      CommunityDetailView()
        .toolbar(.hidden, for: .tabBar)
      
    default:
      CommunityMain()
    }
  }
  
  @ViewBuilder
  private func title() -> some View {
    VStack(alignment: .leading, spacing: 6) {
      Text("커뮤니티")
        .zaniFont(.title1)
        .foregroundStyle(.white)
      
      Text("여러분의 밤샘 꿀팁을 자유롭게 남겨주세요!")
        .zaniFont(.body1)
        .foregroundStyle(.mainGray)
        .frame(maxWidth: .infinity, alignment: .leading)
    }
    .padding(.horizontal, 20)
    .padding(.bottom, 15)
  }
  
  @ViewBuilder
  private func writeButton() -> some View {
    VStack(spacing: 0) {
      Spacer()
      
      HStack(spacing: 0) {
        Spacer()
        
        Button(action: {
          communityPageManager.push(.writing)
        }, label: {
          Image("pencilIcon")
            .padding(18)
            .background(
              Circle()
                .fill(.mainYellow)
            )
        })
        .padding(.horizontal, 20)
        .padding(.bottom, 23)
      }
    }
  }
  
  @ViewBuilder
  private func divider() -> some View {
    Divider()
      .frame(height: 1)
      .overlay(Color.main4)
  }
}

#Preview {
  CommunityMain()
    .environmentObject(CommunityPageManager())
}