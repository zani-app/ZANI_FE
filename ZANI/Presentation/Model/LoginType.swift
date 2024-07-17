//
//  LoginType.swift
//  ZANI
//
//  Created by 정도현 on 3/19/24.
//

import SwiftUI

public enum AuthProvider: CaseIterable {
  case kakao
  case apple
  case email
  
  public var pathName: String {
    switch self {
    case .kakao:
      return "KAKAO"
    case .apple:
      return "APPLE"
    case .email:
      return "EMAIL"
    }
  }
  
  public var loginIcon: Image? {
    switch self {
    case .apple:
      return Image("appleIcon")
    case .kakao:
      return Image("kakaoIcon")
    case .email:
      return nil
    }
  }
  
  public var buttonTitle: String {
    switch self {
    case .apple:
      return "Apple로 계속하기"
    case .kakao:
      return "카카오로 계속하기"
    case .email:
      return "이메일로 계속하기"
    }
  }
  
  public var buttonColor: Color {
    switch self {
    case .apple:
      return Color.white
    case .kakao:
      return Color(red: 255/255, green: 232/255, blue: 18/255)
    case .email:
      return Color.mainGray
    }
  }
}
