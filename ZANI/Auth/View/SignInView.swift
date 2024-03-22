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
  @State private var validationEmail: Bool = false
  @State private var validationPassword: Bool = false
  
  public var body: some View {
    VStack(spacing: 0) {
      ZaniNavigationBar(
        title: "이메일로 로그인",
        leftAction: { authPageManager.pop() }
      )
      .padding(.bottom, 20)
      
      ScrollView(showsIndicators: false) {
        VStack(spacing: 21) {
          AuthTextField(
            fieldType: .email,
            textFormatValidation: AuthTextFieldType.email.validationFunction,
            maximumInputCount: AuthTextFieldType.email.maximumInput,
            isVerified: $validationEmail,
            focusState: $focusState,
            inputText: $emailInput
          )
          
          AuthTextField(
            fieldType: .password,
            textFormatValidation: AuthTextFieldType.password.validationFunction,
            maximumInputCount: AuthTextFieldType.password.maximumInput,
            isVerified: $validationPassword,
            focusState: $focusState,
            inputText: $passwordInput
          )
        }
        .padding(.horizontal, 20)
        .padding(.bottom, 100)
      }
      .scrollDisabled(true)
      
      ZaniMainButton(
        title: "로그인하기",
        isValid: validationEmail && validationPassword,
        action: {  }
      )
      .padding(.vertical, 8)
      .padding(.horizontal, 20)
      
      Spacer()
      
    }
    .navigationBarBackButtonHidden()
    .background(
      Color.main1
    )
    .onTapGesture {
      focusState = nil
    }
  }
}

#Preview {
  SignInView()
}
