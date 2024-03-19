//
//  SignInView.swift
//  ZANI
//
//  Created by 정도현 on 3/19/24.
//

import SwiftUI

public struct SignInView: View {
  @EnvironmentObject private var authPageManager: AuthPageManager
  
  @FocusState private var focusState: AuthTextFieldType?
  
  @State private var emailInput: String = ""
  @State private var passwordInput: String = ""
  
  public var body: some View {
    VStack(spacing: 0) {
      ZaniNavigationBar(
        title: "이메일로 로그인",
        leftAction: { authPageManager.pop() }
      )
      .padding(.bottom, 20)
      
      VStack(spacing: 21) {
        AuthTextField(
          fieldType: .email,
          maximumInputCount: 30,
          isValid: false,
          isVerified: false,
          focusState: $focusState,
          inputText: $emailInput
        )
        
        AuthTextField(
          fieldType: .password,
          maximumInputCount: 30,
          isValid: false,
          isVerified: false,
          focusState: $focusState,
          inputText: $passwordInput
        )
      }
      .padding(.horizontal, 20)
      
      ZaniMainButton(
        title: "로그인하기",
        isValid: true,
        action: { authPageManager.push(.afterAuth) }
      )
      .padding(.top, 106)
      .padding(.horizontal, 20)
      
      Spacer()
      
    }
    .navigationBarBackButtonHidden()
    .background(
      Color.main1
    )
  }
}

#Preview {
  SignInView()
}
