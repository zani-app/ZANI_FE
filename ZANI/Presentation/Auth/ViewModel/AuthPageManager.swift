//
//  AuthPageManager.swift
//  ZANI
//
//  Created by 정도현 on 3/19/24.
//

import SwiftUI

public enum AuthPageState: Hashable {
  case main
  case loginEmail
  case signUpEmail
  case signUpPassword
  case nickname
  case done
  
  public var mainTitle: String {
    switch self {
    case .loginEmail:
      return ""
    case .signUpEmail:
      return "로그인에 사용할\n이메일을 입력해주세요"
    case .signUpPassword:
      return "로그인에 사용할\n비밀번호를 입력해주세요"
    case .nickname:
      return "자니에서 사용할 닉네임을 입력해주세요"
      
    default:
      return ""
    }
  }
  
  public var textfieldTypes: [AuthTextFieldType] {
    switch self {
    case .loginEmail:
      return [.email, .password]
    case .signUpEmail:
      return [.email]
    case .signUpPassword:
      return [.password, .passwordConfirm]
    case .nickname:
      return [.nickname]
    default:
      return []
    }
  }
}

final class AuthPageManager: ObservableObject {
  @Published public var route: [AuthPageState] = []
  
  func push(_ page: AuthPageState) {
    route.append(page)
  }
  
  func pop() {
    route.removeLast()
  }
  
  func popToRoot() {
    route.removeAll()
  }
}
