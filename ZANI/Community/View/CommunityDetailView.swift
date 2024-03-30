//
//  CommunityDetailView.swift
//  ZANI
//
//  Created by 정도현 on 3/31/24.
//

import SwiftUI

public struct CommunityDetailView: View {
  @State private var isShowDeleteIcon: Bool = false
  
  public var body: some View {
    VStack {
      ZaniNavigationBar(title: "글 상세", leftAction: { })
      
      ScrollView {
        LazyVStack(spacing: 0) {
          content()
          
          divider()
          
          likeButton()
        }
      }
    }
    .background(
      .main1
    )
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
        .padding(.vertical, 16)
        
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
      
      Text("컨텐츠 내용")
        .zaniFont(.body1)
        .foregroundStyle(.white)
        .padding(.vertical, 20)
        .frame(maxWidth: .infinity, alignment: .leading)
    }
    .padding(.horizontal, 20)
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
}
