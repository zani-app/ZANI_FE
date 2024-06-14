//
//  CommunityDetailView.swift
//  ZANI
//
//  Created by 정도현 on 3/31/24.
//

import SwiftUI

public struct CommunityDetailView: View {
  @EnvironmentObject private var communityPageManager: CommunityPageManager
  @EnvironmentObject private var communityDataManager: CommunityDataManager
  
  @State private var isShowDeleteIcon: Bool = false
  
  public var body: some View {
    VStack(spacing: 0) {
      ZaniNavigationBar(title: "글 상세", leftAction: { communityPageManager.pop() })
      
      ScrollView {
        LazyVStack(spacing: 0) {
          content()
          
          divider()
          
          likeButton()
        }
      }
    }
    .navigationBarBackButtonHidden()
    .background(
      .main1
    )
    .onTapGesture {
      self.isShowDeleteIcon = false
    }
  }
}

extension CommunityDetailView {
  
  @ViewBuilder
  private func content() -> some View {
    VStack(spacing: 0) {
      HStack {
        VStack(alignment: .leading, spacing: 8) {
          Text("제목")
            .zaniFont(.title1)
            .foregroundStyle(.white)
          
          Text("글 작성자")
            .zaniFont(.body2)
            .foregroundStyle(.mainGray)
            .frame(maxWidth: .infinity, alignment: .leading)
        }
        
        Spacer()
        
        // TODO: 글 작성자인 경우만 보이게
        ZStack(alignment: .trailing) {
          Image("optionIcon")
            .onTapGesture {
              withAnimation {
                self.isShowDeleteIcon.toggle()
              }
            }
          
          if isShowDeleteIcon {
            Button(action: {
              
            }, label: {
              HStack(spacing: 4) {
                Image("trashIcon")
                Text("글 삭제")
              }
              .zaniFont(.body2)
              .foregroundStyle(.errorRed)
              .padding(10)
              .background(
                RoundedRectangle(cornerRadius: 10)
                  .fill(.main2)
                  .overlay(
                    RoundedRectangle(cornerRadius: 10)
                      .stroke(.mainGray)
                  )
              )
            })
            .offset(y: 40)
          }
        }
      }
      .padding(.vertical, 16)
      .padding(.horizontal, 20)
      
      Text("컨텐츠 내용")
        .zaniFont(.body1)
        .foregroundStyle(.white)
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding(.horizontal, 20)
        .padding(.top, 20)
        .padding(.bottom, 27)
      
      // TODO: 사진 있는 경우만
      ScrollView(.horizontal, showsIndicators: false) {
        HStack(spacing: 8) {
          RoundedRectangle(cornerRadius: 10)
            .frame(width: 128, height: 128)
          RoundedRectangle(cornerRadius: 10)
            .frame(width: 128, height: 128)
          RoundedRectangle(cornerRadius: 10)
            .frame(width: 128, height: 128)
        }
        .padding(.horizontal, 20)
      }
      .padding(.bottom, 27)
    }
  }
  
  @ViewBuilder
  private func likeButton() -> some View {
    VStack(spacing: 20) {
      Text("글이 도움이 되었나요?")
        .zaniFont(.body2)
        .foregroundStyle(.white)
      
      Button(action: {
        
      }, label: {
        HStack(spacing: 8) {
          Image("boldHeartIcon")
          
          Text("50")
        }
        .zaniFont(.title1)
        .padding(.vertical, 9)
        .padding(.horizontal, 44)
        .background(
          RoundedRectangle(cornerRadius: 10)
            .foregroundStyle(.main2)
        )
      })
      .foregroundStyle(.mainGray)
    }
    .padding(.top, 16)
    .padding(.bottom, 40)
  }
  
  @ViewBuilder
  private func divider() -> some View {
    Divider()
      .frame(height: 2)
      .overlay(Color.main2)
  }
}

#Preview {
  CommunityDetailView()
    .environmentObject(CommunityPageManager())
    .environmentObject(CommunityDataManager())
}
