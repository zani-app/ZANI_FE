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
  @Published var allNightSummary: AllNightSummaryDTO? = nil
  
  @Published var calendarDate: Date = .now
  
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
  
  /// 달력 및 밤샘 이력 조회
  func requestNightSummary() {
    let summaryDate = self.getMonthYear(date: self.calendarDate)
    
    AllNightersService.shared.requestSummary(year: summaryDate[0], month: summaryDate[1]) { response in
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
