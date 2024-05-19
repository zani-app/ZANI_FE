//
//  SignUpView.swift
//  ZANI
//
//  Created by 정도현 on 3/19/24.
//

import SwiftUI

public struct SignUpView: View {
  @EnvironmentObject private var authPageManager: AuthPageManager
  @EnvironmentObject private var authDataManager: AuthDataManager
  
  @FocusState private var focusState: AuthTextFieldType?
  
  @State private var inputText1 = ""
  @State private var inputText2 = ""
  @State private var validation1: Bool = false
  @State private var validation2: Bool = false
  
  public var pageState: AuthPageState
  
  public init(pageState: AuthPageState) {
    self.pageState = pageState
  }
  
  public var body: some View {
    VStack(alignment: .leading, spacing: 0) {
      navigationBar()
      
      description()
      
      textField()
      
      Spacer()
      
      bottomButton()
    }
    .navigationBarBackButtonHidden()
    .background(
      Color.main1
    )
    .onTapGesture {
      focusState = nil
    }
    .onAppear {
      switch pageState {
      case .loginEmail, .signUpEmail:
        self.focusState = .email
      case .signUpPassword:
        self.focusState = .password
      case .nickname:
        self.focusState = .nickname
      default:
        self.focusState = nil
      }
    }
  }
}

extension SignUpView {
  
  @ViewBuilder
  private func navigationBar() -> some View {
    ZaniNavigationBar(title: "회원가입", leftAction: { authPageManager.pop() })
      .padding(.bottom, 62)
  }
  
  @ViewBuilder
  private func description() -> some View {
    Text(pageState.mainTitle)
      .zaniFont(.head1)
      .foregroundStyle(.white)
      .padding(.horizontal, 20)
  }
  
  @ViewBuilder
  private func textField() -> some View {
    VStack(spacing: 31) {
      if !pageState.textfieldTypes.isEmpty {
        AuthTextField(
          fieldType: pageState.textfieldTypes[0],
          textFormatValidation: pageState.textfieldTypes[0].validationFunction,
          maximumInputCount: pageState.textfieldTypes[0].maximumInput,
          isVerified: $validation1,
          focusState: $focusState,
          inputText: $inputText1
        )
      }
      
      if pageState.textfieldTypes.count > 1 && validation1 {
        AuthTextField(
          fieldType: pageState.textfieldTypes[1],
          textFormatValidation: { $0 == self.inputText1 }, 
          maximumInputCount: pageState.textfieldTypes[1].maximumInput,
          isVerified: $validation2,
          focusState: $focusState,
          inputText: $inputText2
        )
      }
    }
    .padding(.top, 54)
    .padding(.horizontal, 20)
  }
  
  @ViewBuilder
  private func bottomButton() -> some View {
    ZaniMainButton(
      title: "다음",
      isValid: pageState.textfieldTypes.count == 1 ? validation1 : validation1 && validation2,
      action: {
        switch self.pageState {
        case .signUpEmail:
          authPageManager.push(.signUpPassword)
        case .signUpPassword:
          authPageManager.push(.nickname)
        case .nickname:
          authPageManager.push(.done)
          
        default:
          // TODO: 분기처리
          return
        }
      }
    )
    .padding(.horizontal, 20)
    .padding(.vertical, 8)
  }
}

#Preview {
  SignUpView(pageState: .signUpEmail)
    .environmentObject(AuthPageManager())
    .environmentObject(AuthDataManager())
}

