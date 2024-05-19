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
import UIKit

final class MyPageDataManager: ObservableObject {
  
  @Published var userInfo: UserInfoDTO? = nil
  @Published var followList: [FollowDTO]? = nil
  @Published var allNightSummary: AllNightSummaryDTO? = nil
  @Published var calendarDate: Date = .now
  
  private var requestFollowListUseCase: RequestFollowListUseCaseImpl = RequestFollowListUseCaseImpl(userRepository: DefaultUserRepository())
  private var requestNicknameDuplicateUseCase: RequestNicknameDuplicateUseCaseImpl = RequestNicknameDuplicateUseCaseImpl(userRepository: DefaultUserRepository())
  private var requestNightSummaryUseCase: RequestNightSummaryUseCaseImpl = RequestNightSummaryUseCaseImpl(userRepository: DefaultUserRepository())
  private var requestUserInfoUseCase: RequestUserInfoUseCaseImpl = RequestUserInfoUseCaseImpl(userRepository: DefaultUserRepository())
  
  /// 유저 정보 호출
  func requestUserDetail() {
    requestUserInfoUseCase.execute { response in
      switch(response) {
      case .success(let data):
        if let data = data as? UserInfoDTO {
          self.userInfo = data
        }
        
      default:
        print("data fetch Error")
      }
    }
  }
  
  /// 유저 정보 업데이트
  func requestUpdateUserProfile() {
    //    MyPageService.shared.updateUserInfo(nickname: "test", image: UIImage()) { response in
    //      switch(response) {
    //      case .success(let data):
    //        print("nice!")
    //
    //      default:
    //        print("data fetch Error")
    //      }
    //    }
    
    let param: Parameters = [
      "message":
        [ "nickname": "test" ]
    ]
    
    let imageData = UIImage().pngData()!
  }
  
  /// 팔로우 리스트 출력
  func requestFollowList() {
    requestFollowListUseCase.execute { response in
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
  
  /// 달력 및 밤샘 이력 조회
  func requestNightSummary() {
    let summaryDate = self.getMonthYear(date: self.calendarDate)
    
    requestNightSummaryUseCase.execute(year: summaryDate[0], month: summaryDate[1]) { response in
      switch(response) {
      case .success(let data):
        if let data = data as? AllNightSummaryDTO {
          self.allNightSummary = data
          print(data, "data")
        }
        
      default:
        print("data fetch Error")
      }
    }
  }
  
  /// 닉네임 검증
  func checkNicnameValidation(nickname: String) {
    requestNicknameDuplicateUseCase.execute(nickname: nickname) { response in
      switch(response) {
      case .success(let data):
        if let data = data as? Bool {
          print(data, "data")
          
          if data {
            let imageData = UIImage(systemName: "chevron.left")
            
            self.requestPatch(nickname: nickname, image: imageData)
          }
        }
        
      default:
        print("data fetch Error")
      }
    }
  }
  
  func checkCalendarValidation() -> Bool {
    let nowData = getMonthYear(date: .now)
    let calData = getMonthYear(date: self.calendarDate)
    
    if nowData[0] == calData[0] {
      if nowData[1] > calData[1] {
        return true
      }
    } else if nowData[0] > calData[0] {
      return true
    }
    
    return false
  }
  
  /// for 달력 (년, 달)
  private func getMonthYear(date: Date) -> [Int] {
    let calendar = Calendar.current
    let year = calendar.component(.year, from: date)
    let month = calendar.component(.month, from: date)
    return [year, month]
  }
  
  func convertSecondsToHoursMinutesSeconds(seconds: Int) -> (hours: Int, minutes: Int, seconds: Int) {
    let hours = seconds / 3600
    let minutes = (seconds % 3600) / 60
    let seconds = (seconds % 3600) % 60
    return (hours, minutes, seconds)
  }
  
  func fetchNightDate(data: [NightRecordDTO]) -> [(teamId: Int, endDate: Int, duration: Int)] {
    var tempArray: [(teamId: Int, endDate: Int, duration: Int)] = []
    
    for data in data {
      let historyTeamId = data.historyTeamId
      let endData = data.endAt[3]
      let duration = data.duration / 3600
      
      tempArray.append((historyTeamId, endData, duration))
    }
    
    return tempArray
  }
  
  func findIndexMatchingNightRecords(data: [NightRecordDTO], targetDate: Int) -> Int? {
    for (index, record) in data.enumerated() {
      if record.endAt[2] == targetDate {
        return index
      }
    }
    return nil
  }
  
  // ** Multipart Form **
  func requestPatch(nickname: String, image: UIImage?) {
    let URL = "https://dongkyeom.com/api/v1/user"
    
    var header : HTTPHeaders = [
      "Content-Type" : "multipart/form-data",
    ]
    
    if let accessToken = UserDefaults.standard.string(forKey: "accessToken") {
      header["Authorization"] = "Bearer \(accessToken)"
    }
  
    let parameters: [String : Any] = [
      "nickname": nickname
    ]
    
    AF.upload(multipartFormData: { multipartFormData in
      for (key, value) in parameters {
        multipartFormData.append("\(value)".data(using: .utf8)!, withName: key)
      }
      
      if let image = image?.pngData() {
        multipartFormData.append(image, withName: "file", fileName: "\(image).png", mimeType: "image/png")
      }
    }, to: URL, usingThreshold: UInt64.init(), method: .patch, headers: header).response { response in
      guard let statusCode = response.response?.statusCode, statusCode == 200 else {
        return
      }
    }
  }
}
