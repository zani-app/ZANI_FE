//
//  LoginManager.swift
//  ZANI
//
//  Created by 정도현 on 3/22/24.
//

import Combine
import Foundation
import KakaoSDKUser
import Alamofire

final class LoginManager: ObservableObject {
  
  @Published var loginType: AuthProvider? = nil
  
  /// MARK: KAKAO Login
  func handleKakaoLogin() {
    // 카카오톡 설치 된 경우 - 카카오톡으로 로그인
    if (UserApi.isKakaoTalkLoginAvailable()) {
      UserApi.shared.loginWithKakaoTalk {(oauthToken, error) in
        if let error = error {
          print(error)
        }
        else {
          self.signUpUserWithSocialLogin(loginPath: .kakao)
        }
      }
    }
    
    // 카카오 설치 안되어 있을 때 - 카카오 계정으로 로그인
    else {
      UserApi.shared.loginWithKakaoAccount {(oauthToken, error) in
        if let error = error {
          print(error)
        }
        else {
          self.signUpUserWithSocialLogin(loginPath: .kakao)
        }
      }
    }
  }
  
  /// Social Login 회원가입 호출
  private func signUpUserWithSocialLogin(loginPath: AuthProvider) {
    UserApi.shared.me() {(user, error) in
      if let error = error {
        print(error)
      }
      else {
        if let user = user {
          
          AuthService.shared.requestSocialSignUp(id: String(user.id ?? 0), provider: loginPath) { response in
            switch(response) {
            case .success(let data):
              if let data = data as? SignUpDTO {
                UserDefaults.standard.set(data.accessToken, forKey: "accessToken")
                self.loginType = loginPath
                self.getUserDetail()
              }
              
            default:
              print("error")
            }
          }
        }
      }
    }
  }
  
  // MARK: KakaoLogout
  func handleKakaoLogout() async -> Bool {
    
    await withCheckedContinuation { continuation in
      UserApi.shared.logout {(error) in
        if let error = error {
          print(error)
          continuation.resume(returning: false)
        }
        else {
          print("logout() success.")
          continuation.resume(returning: true)
        }
      }
    }
  }
}

// MARK: User 관련 API
extension LoginManager {
  func getUserDetail() {
    UserService.shared.requestUserInfo { response in
      switch(response) {
      case .success(let data):
        if let data = data as? UserInfoDTO {
          print(data.nickname, "!@#!@#")
        }
        
      default:
        print("errorGetUser")
      }
    }
  }
  
  func checkNicknameValidation(nickName: String) {
    
  }
}
