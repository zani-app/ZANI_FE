//
//  LoginManager.swift
//  ZANI
//
//  Created by 정도현 on 3/22/24.
//

import Alamofire
import AuthenticationServices
import Combine
import Foundation
import KakaoSDKUser

final class AuthDataManager: NSObject, ObservableObject {
  
  @Published var loginType: AuthProvider? = nil
  @Published var isShowNicknameView: Bool = false
  @Published var isLogin: Bool = false
  
  private var requestSocialSignUpUseCase: RequestSocialSignUpUseCaseImpl = RequestSocialSignUpUseCaseImpl(userRepository: DefaultUserRepository())
  private var requestUserInfoUseCase: RequestUserInfoUseCaseImpl = RequestUserInfoUseCaseImpl(userRepository: DefaultUserRepository())
  
  /// MARK: KAKAO Login
  public func handleKakaoLogin() {
    // 카카오톡 설치 된 경우 - 카카오톡으로 로그인
    if (UserApi.isKakaoTalkLoginAvailable()) {
      UserApi.shared.loginWithKakaoTalk {(oauthToken, error) in
        if let error = error {
          print(error.localizedDescription)
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
          print(error.localizedDescription)
        }
        else {
          self.signUpUserWithSocialLogin(loginPath: .kakao)
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
  
  /// Social Login 회원가입 호출
  private func signUpUserWithSocialLogin(loginPath: AuthProvider) {
    UserApi.shared.me() { (user, error) in
      if let error = error {
        print(error)
      }
      else {
        if let user = user {
          self.requestSocialSignUpUseCase.execute(
            id: String(user.id ?? 0),
            provider: loginPath
          ) { response in
            switch(response) {
            case .success(let data):
              if let data = data as? SignUpDTO {
                UserDefaults.standard.set(data.accessToken, forKey: "accessToken")
                print("Access Token: \(data.accessToken)")
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

// MARK: User 관련 API
extension AuthDataManager {
  func getUserDetail() {
    requestUserInfoUseCase.execute { response in
      switch(response) {
      case .success(let data):
        if let data = data as? UserInfoDTO {
          self.isLogin = true
        } else {
          self.isShowNicknameView = true
        }
        
      default:
        print("errorGetUser")
      }
    }
  }
  
  func checkNicknameValidation(nickName: String) {
    
  }
}


// MARK: Apple Login delegate
extension AuthDataManager: ASAuthorizationControllerDelegate, ASAuthorizationControllerPresentationContextProviding{
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
