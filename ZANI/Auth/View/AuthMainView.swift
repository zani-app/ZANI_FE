//
//  AuthMainView.swift
//  ZANI
//
//  Created by 정도현 on 3/19/24.
//

import SwiftUI

public struct AuthMainView: View {
  public var body: some View {
    VStack(spacing: 0) {
      title()
      
      Spacer()
      
      loginButton()
    }
    .padding(.horizontal, 20)
    .background(
      Color.main1
    )
  }
}

extension AuthMainView {
  
  @ViewBuilder
  private func title() -> some View {
    VStack(spacing: 12) {
      Text("로그인/회원가입")
        .zaniFont(.head2)
        .foregroundStyle(.white)
      Text("밤샘메이트들과 함께하는\n밤샘 서비스, 자니")
        .zaniFont(.title2)
        .multilineTextAlignment(.center).foregroundStyle(Color.main6)
    }
    .padding(.top, 201)
  }
  
  @ViewBuilder
  private func loginButton() -> some View {
    VStack(spacing: 29) {
      VStack(spacing: 16) {
        signInButton(type: .kakao, action: { })
        signInButton(type: .apple, action: { })
        signInButton(type: .email, action: { })
      }
      
      Text("이메일로 회원가입")
        .zaniFont(.body1)
        .foregroundStyle(Color.main6)
        .padding(.bottom, 87)
    }
  }
  
  @ViewBuilder
  private func signInButton(
    type: LoginType,
    action: @escaping () -> Void
  ) -> some View {
    Text(type.buttonTitle)
      .zaniFont(.title2)
      .foregroundStyle(.black)
      .frame(maxWidth: .infinity)
      .background(
        Capsule()
          .frame(height: 52)
          .foregroundStyle(type.buttonColor)
      )
      .overlay(alignment: .leading) {
        if let image = type.loginIcon {
          image
            .padding(.leading, 16)
        }
      }
      .frame(height: 52)
      .onTapGesture {
        action()
      }
  }
}

#Preview {
  AuthMainView()
}
