//
//  SignUpDoneView.swift
//  ZANI
//
//  Created by 정도현 on 3/19/24.
//

import SwiftUI

public struct SignUpDoneView: View {
  @EnvironmentObject private var authPageManager: AuthPageManager
  
  public var body: some View {
    VStack(spacing: 0) {
      checkImage()
      
      description()
      
      Spacer()
      
      bottomButton()
    }
    .padding(.horizontal, 20)
    .navigationBarBackButtonHidden()
    .background(
      Color.main1
    )
  }
}

extension SignUpDoneView {
  
  @ViewBuilder
  private func checkImage() -> some View {
    Image("signUpDoneCheckIcon")
      .padding(.top, 79)
      .padding(.bottom, 63)
  }
  
  @ViewBuilder
  private func description() -> some View {
    VStack(spacing: 7) {
      Text("회원가입이 완료되었습니다!")
        .zaniFont(.head1)
      
      Text("밤샘 팀에 가입하여 메이트들과\n밤샘을 함께 성공해요!")
        .zaniFont(.body1)
    }
    .foregroundStyle(.white)
    .multilineTextAlignment(.center)
  }
  
  @ViewBuilder
  private func bottomButton() -> some View {
    ZaniMainButton(
      title: "다음",
      isValid: true,
      action: { authPageManager.push(.afterAuth) }
    )
    .padding(.vertical, 8)
  }
}

#Preview {
  SignUpDoneView()
    .environmentObject(AuthPageManager())
}
