//
//  ChangeNicknameView.swift
//  ZANI
//
//  Created by 정도현 on 3/20/24.
//

import SwiftUI

public struct ChangeNicknameView: View {
  @EnvironmentObject private var myPagePageManager: MyPagePageManager
  @EnvironmentObject private var myPageManager: MyPageManager
  
  @State private var userInput: String = ""
  
  @FocusState private var focusState
  
  public var userName: String
  
  public init(userName: String) {
    self.userName = userName
  }
  
  public var body: some View {
    VStack(spacing: 0) {
      navigationBar()
      
      profileImage()
      
      textField()
      
      Spacer()
      
      bottomButton()
    }
    .navigationBarBackButtonHidden()
    .onAppear {
      userInput = userName
    }
    .background(
      Color.main1
    )
  }
}

extension ChangeNicknameView {
  
  @ViewBuilder
  private func navigationBar() -> some View {
    ZaniNavigationBar(
      title: "닉네임 변경",
      leftAction: { myPagePageManager.pop() }
    )
  }
  
  @ViewBuilder
  private func profileImage() -> some View {
    Image("profileIcon")
      .resizable()
      .frame(width: 98, height: 98)
      .padding(.top, 58)
  }
  
  @ViewBuilder
  private func textField() -> some View {
    VStack(alignment: .leading, spacing: 13) {
      Text("닉네임")
        .foregroundStyle(.white)
        .zaniFont(.body1)
      
      ZaniTextField(
        placeholderText: " 바꿀 닉네임을 작성해주세요.",
        placeholderTextStyle: .body1,
        keyboardType: .default,
        maximumInputCount: AuthTextFieldType.nickname.maximumInput,
        inputText: $userInput
      )
    }
    .padding(.top, 50)
    .padding(.horizontal, 20)
  }
  
  @ViewBuilder
  private func bottomButton() -> some View {
    ZaniMainButton(
      title: "수정 완료하기",
      isValid: !userInput.isEmpty && userInput.count < AuthTextFieldType.nickname.maximumInput && userInput != userName,
      action: { myPageManager.checkNicnameValidation(nickname: self.userName) }
    )
    .padding(.horizontal, 20)
    .padding(.bottom, 28)
  }
}

#Preview {
  ChangeNicknameView(userName: "test")
    .environmentObject(MyPagePageManager())
    .environmentObject(MyPageManager())
}
