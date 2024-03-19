//
//  AuthTextFieldType.swift
//  ZANI
//
//  Created by 정도현 on 3/19/24.
//

import SwiftUI

public enum AuthTextFieldType {
  case email
  case password
  case passwordConfirm
  case nickname
  
  public var title: String {
    switch self {
    case .email:
      return "이메일"
    case .password:
      return "비밀번호"
    case .passwordConfirm:
      return "비밀번호 확인"
    case .nickname:
      return "닉네임"
    }
  }
  
  public var placeholder: String {
    switch self {
    case .email:
      return "abc@email.com"
    case .password:
      return "영문, 숫자, 특수문자 포함 8자 이상"
    case .passwordConfirm:
      return "비밀번호를 다시 한 번 입력해주세요"
    case .nickname:
      return "닉네임을 입력해주세요"
    }
  }
  
  public var errorText: String {
    switch self {
    case .email:
      return "올바른 이메일을 입력해주세요"
    case .password:
      return "조건에 맞지 않는 비밀번호입니다."
    case .passwordConfirm:
      return "비밀번호가 일치하지 않습니다."
    case .nickname:
      return "존재하는 닉네임 입니다."
    }
  }
  
  public var keyboardType: UIKeyboardType {
    switch self {
    case .email:
      return .emailAddress
    default:
      return .default
    }
  }
}
