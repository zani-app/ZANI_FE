//
//  MyPageManager.swift
//  ZANI
//
//  Created by 정도현 on 3/23/24.
//

import Combine
import Foundation
import KakaoSDKUser
import Alamofire

final class MyPageManager: ObservableObject {
  
  @Published var userInfo: UserInfoDTO? = nil
  @Published var followList: [FollowDTO]? = nil
 
  /// 유저 정보 호출
  func requestUserDetail() {
    MyPageService.shared.requestUserInfo { response in
      switch(response) {
      case .success(let data):
        if let data = data as? UserInfoDTO {
          self.userInfo = data
          print(data.nickname, "TEST")
        }
        
      default:
        print("data fetch Error")
      }
    }
  }
  
  /// 팔로우 리스트 출력
  func requestFollowList() {
    FollowingService.shared.requestFollowList { response in
      switch(response) {
      case .success(let data):
        if let data = data as? [FollowDTO] {
          self.followList = data
        }
        
      default:
        print("data fetch Error")
      }
    }
  }
}
