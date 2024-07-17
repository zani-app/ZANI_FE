//
//  AuthMainView.swift
//  ZANI
//
//  Created by 정도현 on 3/19/24.
//

import SwiftUI

public struct AuthMainView: View {
  @EnvironmentObject private var authDataManager: AuthDataManager
  @StateObject private var authPageManager = AuthPageManager()
  
  public var body: some View {
    NavigationStack(path: $authPageManager.route) {
      VStack(spacing: 0) {
        title()
        
        Spacer()
        
        loginButton()
      }
      .padding(.horizontal, 20)
      .onAppear {
        authDataManager.loginType = nil
      }
      .onChange(of: authDataManager.isShowNicknameView, perform: { value in
        if value {
          authPageManager.push(.nickname)
        }
      })
      .navigationDestination(for: AuthPageState.self) { pageState in
        authPageDestination(pageState)
      }
      .background(
        Color.main1
      )
    }
  }
}

extension AuthMainView {
  
  @ViewBuilder
  private func authPageDestination(_ type: AuthPageState) -> some View {
    switch type {
    case .signUpEmail, .signUpPassword, .nickname:
      SignUpView(pageState: type)
        .environmentObject(authPageManager)
      
    case .done:
      SignUpDoneView()
        .environmentObject(authPageManager)
      
    case .loginEmail:
      SignInView()
        .environmentObject(authPageManager)
      
    case .main:
      AuthMainView()
        .environmentObject(authPageManager)
    }
  }
  
  @ViewBuilder
  private func title() -> some View {
    VStack(spacing: 12) {
      Text("로그인/회원가입")
        .zaniFont(.head2)
        .foregroundStyle(.white)
      
      Text("밤샘메이트들과 함께하는\n밤샘 서비스, 자니")
        .zaniFont(.title2)
        .multilineTextAlignment(.center).foregroundStyle(Color.mainGray)
    }
    .padding(.top, 201)
  }
  
  @ViewBuilder
  private func loginButton() -> some View {
    VStack(spacing: 29) {
      VStack(spacing: 16) {
        signInButton(
          type: .kakao,
          action: {
            authDataManager.handleKakaoLogin()
          }
        )
        
        signInButton(
          type: .apple,
          action: {
            authDataManager.requestAppleLogin()
          }
        )
        
        signInButton(
          type: .email,
          action: {
            authPageManager.push(.loginEmail)
          }
        )
      }
      
      Text("이메일로 회원가입")
        .zaniFont(.body1)
        .foregroundStyle(Color.mainGray)
        .padding(.bottom, 87)
        .onTapGesture {
          authPageManager.push(.signUpEmail)
        }
    }
  }
  
  @ViewBuilder
  private func signInButton(
    type: AuthProvider,
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
    .environmentObject(AuthPageManager())
}
