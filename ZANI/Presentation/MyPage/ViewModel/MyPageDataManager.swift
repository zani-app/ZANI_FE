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
import _PhotosUI_SwiftUI

final class MyPageDataManager: ObservableObject {
  
  @Published private(set) var userInfo: UserInfoDTO? = nil
  @Published private(set) var followList: [FollowDTO]? = nil
  @Published private(set) var allNightSummary: AllNightSummaryDTO? = nil
  @Published var calendarDate: Date = .now
  @Published private(set) var badgeList: [BadgeDTO] = []
  
  @Published var selectedImage: PhotosPickerItem?
  @Published var selectedImageData: Data?
  
  @Published private(set) var isSuccess: Bool = false
  
  private var requestFollowListUseCase: RequestFollowListUseCaseImpl = RequestFollowListUseCaseImpl(userRepository: DefaultUserRepository())
  private var requestNicknameDuplicateUseCase: RequestNicknameDuplicateUseCaseImpl = RequestNicknameDuplicateUseCaseImpl(userRepository: DefaultUserRepository())
  private var requestNightSummaryUseCase: RequestNightSummaryUseCaseImpl = RequestNightSummaryUseCaseImpl(userRepository: DefaultUserRepository())
  private var requestUserInfoUseCase: RequestUserInfoUseCaseImpl = RequestUserInfoUseCaseImpl(userRepository: DefaultUserRepository())
  private var requestAchievementUseCase: RequestAchievementUseCaseImpl = RequestAchievementUseCaseImpl(userRepository: DefaultUserRepository())
  
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
  
  func deinitImageData() {
    self.selectedImageData = nil
    self.selectedImage = nil
  }
  
  /// 달력 및 밤샘 이력 조회
  func requestNightSummary() {
    let summaryDate = self.getMonthYear(date: self.calendarDate)
    
    requestNightSummaryUseCase.execute(year: summaryDate[0], month: summaryDate[1]) { response in
      switch(response) {
      case .success(let data):
        if let data = data as? AllNightSummaryDTO {
          self.allNightSummary = data
          print(data)
        }
        
      default:
        print("data fetch Error")
      }
    }
  }
  
  /// 유저 칭호
  func requestUserAchievement() {
    requestAchievementUseCase.execute { response in
      switch(response) {
        // TODO: Data Decoding
      case .success(let data):
        if let data = data as? [BadgeDTO] {
          self.badgeList = data
          print(data)
        }
        
      default:
        print("data fetch Error")
      }
    }
  }
  
  /// 닉네임 검증 + 유저 정보 수정
  func checkNicnameValidation(nickname: String) {
    self.isSuccess = false
    
    requestNicknameDuplicateUseCase.execute(nickname: nickname) { response in
      switch(response) {
      case .success:
        var imageData: UIImage? = nil
        
        if let data = self.selectedImageData {
          imageData = UIImage(data: data)
        }
        
        self.requestUserInfoUseCase.update(image: imageData, nickname: nickname) { response in
          switch(response) {
          case .success:
            self.isSuccess = true
            
          default:
            print("data fetch Error")
          }
        }
        
      default:
        print("data fetch Error")
      }
    }
  }
  
  /// 닉네임 변경 버튼 Validation
  func changeNicknameButtonValidation(userInput: String) -> Bool {
    if let userInfo = userInfo {
      return (!userInput.isEmpty && userInput.count < AuthTextFieldType.nickname.maximumInput && userInput != userInfo.nickname) || self.selectedImageData != nil
    } else {
      return false
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
}
