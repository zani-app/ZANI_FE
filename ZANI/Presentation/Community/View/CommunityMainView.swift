//
//  CommunityMainView.swift
//  ZANI
//
//  Created by 정도현 on 3/14/24.
//

import SwiftUI

public struct CommunityMainView: View {
  @StateObject private var communityDataManager = CommunityDataManager()
  
  public var body: some View {
    NavigationStack(
      path: $communityDataManager.pageController.route
    ) {
      ZStack {
        VStack(spacing: 0) {
          title()
            .padding(.top, 10)
          
          ScrollView {
            LazyVStack(spacing: 0) {
              ForEach(communityDataManager.postList?.posts ?? []) { article in
                divider()
                
                CommunityBoardBox(article: article)
                  .onTapGesture {
                    communityDataManager.action(.tappedArticle(id: article.postId))
                  }
              }
              
              divider()
            }
          }
        }
        
        writeButton()
      }
      .onAppear {
        communityDataManager.action(.mainViewAppear)
      }
      .background(
        Color.main1
      )
      .navigationDestination(for: CommunityPageState.self) { pageState in
        communityPageDestination(pageState)
      }
    }
    .failureAlert(
      isAlert: Binding(
        get: {
          if case .failure(_) = communityDataManager.viewState {
            return true
          } else {
            return false
          }
        }, set: { value in
          communityDataManager.viewState = .success
        }
      ),
      description: communityDataManager.errorMsg,
      action: { }
    )
  }
}

extension CommunityMainView {
  
  @ViewBuilder
  private func communityPageDestination(_ type: CommunityPageState) -> some View {
    switch type {
    case .main:
      CommunityMainView()
      
    case .writing:
      CommunityWritingView()
        .toolbar(.hidden, for: .tabBar)
        .environmentObject(communityDataManager)
      
    case .detail:
      CommunityDetailView()
        .toolbar(.hidden, for: .tabBar)
        .environmentObject(communityDataManager)
      
    default:
      CommunityMainView()
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
          communityDataManager.action(.tappedWritingButton)
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
  CommunityMainView()
}
