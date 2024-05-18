//
//  ChattingManager.swift
//  ZANI
//
//  Created by 정도현 on 3/24/24.
//

import Combine
import Foundation
import KakaoSDKUser
import Alamofire
import UIKit

final class ChattingManager: ObservableObject {
  
  @Published var chatList: ChatDTO?
  @Published var nickname: String?
  
  /// 유저 정보 호출
  func requestChattingList(teamId: Int, page: Int, size: Int) {
    ChattingService.shared.requestChattingHistory(teamId: teamId, page: page, size: size) { response in
      switch(response) {
      case .success(let data):
        if let data = data as? ChatDTO {
          self.chatList = data
        }
        
      default:
        print("data fetch Error")
      }
    }
  }
}
