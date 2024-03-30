//
//  CommunityWritingView.swift
//  ZANI
//
//  Created by 정도현 on 3/31/24.
//

import SwiftUI

public struct CommunityWritingView: View {
  @EnvironmentObject private var communityPageManager: CommunityPageManager
  
  @State private var title: String = ""
  @State private var content: String = ""
  
  public var body: some View {
    VStack(spacing: 0) {
      ZaniNavigationBar(title: "글쓰기", leftAction: { communityPageManager.pop() })
        .padding(.bottom, 22)
      
      contents()
      
      Spacer()
      
      bottomButton()
    }
    .navigationBarBackButtonHidden()
    .background(
      .main1
    )
  }
}

extension CommunityWritingView {
  
  @ViewBuilder
  private func contents() -> some View {
    ScrollView {
      LazyVStack(alignment: .trailing, spacing: 11) {
        ZaniTextField(
          placeholderText: "제목을 입력하세요",
          placeholderTextStyle: .body1,
          keyboardType: .default,
          maximumInputCount: 20,
          inputText: $title
        )
        
        ZaniTextField(
          placeholderText: "여러분의 밤샘 꿀팁을 적어주세요!",
          placeholderTextStyle: .body1,
          keyboardType: .default,
          maximumInputCount: 200,
          lineLimit: 10,
          inputText: $content
        )
        
        Button(action: {
          
        }, label: {
          HStack(spacing: 8) {
            Image("cameraIcon")
            Text("사진 등록하기")
          }
          .zaniFont(.body2)
          .padding(8)
          .foregroundStyle(.mainGray)
          .background(
            RoundedRectangle(cornerRadius: 10)
              .stroke(Color.mainGray)
          )
        })
      }
      .padding(.horizontal, 20)
    }
  }
  
  @ViewBuilder
  private func bottomButton() -> some View {
    ZaniMainButton(
      title: "글 등록하기",
      isValid: true,
      action: { }
    )
    .padding(.horizontal, 20)
    .padding(.vertical, 10)
  }
}

#Preview {
  CommunityWritingView()
    .environmentObject(CommunityPageManager())
}
