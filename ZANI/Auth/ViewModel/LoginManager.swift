//
//  LoginManager.swift
//  ZANI
//
//  Created by 정도현 on 3/22/24.
//

import AuthenticationServices
import Combine
import Foundation
import KakaoSDKUser
import Alamofire

final class LoginManager: NSObject, ObservableObject {
  
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
  
  /// MARK: KakaoLogout
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
  
  /// MARK: Apple Login Request
  func requestAppleLogin() {
    let appleIDProvider = ASAuthorizationAppleIDProvider()
    let request = appleIDProvider.createRequest()
    request.requestedScopes = [.fullName, .email]
    
    let authorizationController = ASAuthorizationController(authorizationRequests: [request])
    authorizationController.delegate = self
    authorizationController.presentationContextProvider = self
    authorizationController.performRequests()
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
                print(data.accessToken, "hear~")
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
}

// MARK: Apple Login delegate
extension LoginManager: ASAuthorizationControllerDelegate, ASAuthorizationControllerPresentationContextProviding{
  func presentationAnchor(for controller: ASAuthorizationController) -> ASPresentationAnchor {
    guard let window = UIApplication.shared.windows.first else {
      fatalError("no window found!")
    }
    return window
  }
  
  /// Login 성공
  func authorizationController(controller: ASAuthorizationController, didCompleteWithAuthorization authorization: ASAuthorization) {
    switch authorization.credential {
    case let appleIDCredential as ASAuthorizationAppleIDCredential:
      let userIdentifier = appleIDCredential.user
      let fullName = appleIDCredential.fullName
      let email = appleIDCredential.email
      
      if let authorizationCode = appleIDCredential.authorizationCode,
         let identityToken = appleIDCredential.identityToken,
         let authCodeString = String(data: authorizationCode, encoding: .utf8),
         let identifyTokenString = String(data: identityToken, encoding: .utf8) {
        print("authorizationCode: \(authorizationCode)")
        print("identityToken: \(identityToken)")
        print("authCodeString: \(authCodeString)")
        print("identifyTokenString: \(identifyTokenString)")
      }
      
      print("useridentifier: \(userIdentifier)")
      print("fullName: \(fullName)")
      print("email: \(email)")
      
      print("🔑 Apple login Success")
      self.loginType = .apple
      
    // Sign in using an existing iCloud Keychain credential.
    case let passwordCredential as ASPasswordCredential:
      let username = passwordCredential.user
      let password = passwordCredential.password
      
      print("username: \(username)")
      print("password: \(password)")
      
      print("🔑 Apple login Success")
      self.loginType = .apple
      
    default:
      break
    }
  }
  
  /// Login 실패
  func authorizationController(controller: ASAuthorizationController, didCompleteWithError error: Error) {
    print("🔑 Apple login failed - \(error.localizedDescription)")
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
