//
//  MyPageCalendarView.swift
//  ZANI
//
//  Created by 정도현 on 3/20/24.
//

import SwiftUI

public struct MyPageCalendarView: View {
  @EnvironmentObject private var myPageDataManager: MyPageDataManager
  
  @State private var offset: CGSize = CGSize()
  
  let days: [String] = ["일", "월", "화", "수", "목", "금", "토"]
  
  public var body: some View {
    VStack(spacing: 0) {
      title()
      
      calendarContents()
      
      Spacer()
    }
    .padding(.top, 20)
    .background(
      RoundedRectangle(cornerRadius: 20)
        .fill(Color.main2)
        .frame(height: 375)
    )
    .frame(height: 375)
    .onAppear {
      myPageDataManager.calendarDate = .now
    }
    .onChange(of: myPageDataManager.calendarDate, perform: { value in
      myPageDataManager.requestNightSummary()
    })
  }
}

extension MyPageCalendarView {
  private func title() -> some View {
    VStack(spacing: 0) {
      HStack(spacing: 16) {
        Image(systemName: "chevron.left")
          .frame(width: 24, height: 24)
          .onTapGesture {
            moveMonth(offset: -1)
          }
        
        Text(calendarTitleFormat(date: myPageDataManager.calendarDate))
        
        Image(systemName: "chevron.right")
          .frame(width: 24, height: 24)
          .onTapGesture {
            if myPageDataManager.checkCalendarValidation() {
              moveMonth(offset: 1)
            }
          }
          .foregroundStyle(
            myPageDataManager.checkCalendarValidation() ? .white : .mainGray
          )
      }
      .font(.custom("Pretendard-Bold", size: 18))
      .lineSpacing(2)
      .padding(.bottom, 23)
    }
    .foregroundStyle(.white)
  }
  
  private func calendarContents() -> some View {
    let daysInMonth: Int = numberOfDays(in: myPageDataManager.calendarDate)
    let firstWeekday: Int = firstWeekdayOfMonth(in: myPageDataManager.calendarDate) - 1
    
    return VStack(spacing: 0) {
      HStack(spacing: 0) {
        ForEach(self.days, id: \.self) { day in
          Text(day)
            .foregroundStyle(.white)
            .font(.custom("Pretendard-Regular", size: 16))
            .lineSpacing(9)
            .frame(height: 25)
          
          if day != "토" {
            Spacer()
          }
        }
      }
      .padding(.horizontal, 34)
      .padding(.bottom, 4)
      
      if let nightSummary = myPageDataManager.allNightSummary {
        LazyVGrid(
          columns: Array(repeating: GridItem(spacing: 6), count: 7), spacing: 4
        ) {
          ForEach(0 ..< daysInMonth + firstWeekday, id: \.self) { index in
            if index < firstWeekday {
              Rectangle()
                .frame(width: 40, height: 40)
                .opacity(0)
            } else {
              let day = index - firstWeekday + 1
              let nightRecordsIdx = myPageDataManager.findIndexMatchingNightRecords(data: nightSummary.allNightersRecords, targetDate: day)
              
              if let nightRecordsIdx = nightRecordsIdx {
                dateView(day: day, nightData: nightSummary.allNightersRecords[nightRecordsIdx])
              } else {
                dateView(day: day, nightData: nil)
              }
            }
          }
        }
        .padding(.horizontal, 18)
      } else {
        ProgressView()
          .frame(maxWidth: .infinity, maxHeight: .infinity)
      }
    }
  }
  
  public func dateView(day: Int, nightData: NightRecordDTO?) -> some View {
    ZStack(alignment: .center) {
      Rectangle()
        .frame(width: 40, height: 40)
        .opacity(0)
      
      if let nightData = nightData {
        let time: Int = nightData.duration / 3600
        
        if time < 3 {
          Image("moon1")
            .resizable()
            .frame(width: 40, height: 40)
        } else if time < 6 {
          Image("moon2")
            .resizable()
            .frame(width: 40, height: 40)
        } else if time < 10 {
          Image("moon3")
            .resizable()
            .frame(width: 40, height: 40)
        } else {
          Image("moon4")
            .resizable()
            .frame(width: 40, height: 40)
        }
      }
    
      Text(String(day))
        .font(.custom("Pretendard-Regular", size: 20))
        .lineSpacing(5)
        .foregroundStyle(nightData != nil ? .black : .white)
    }
  }
}

extension MyPageCalendarView {
  
  private func startOfMonth() -> Date {
    let components = Calendar.current.dateComponents(
      [.year, .month],
      from: myPageDataManager.calendarDate
    )
    
    return Calendar.current.date(from: components)!
  }
  
  private func numberOfDays(in date: Date) -> Int {
    return Calendar.current.range(of: .day, in: .month, for: date)?.count ?? 0
  }
  
  private func firstWeekdayOfMonth(in date: Date) -> Int {
    let components = Calendar.current.dateComponents([.year, .month], from: date)
    let firstDayOfMonth = Calendar.current.date(from: components)!
    
    return Calendar.current.component(.weekday, from: firstDayOfMonth)
  }
  
  private func moveMonth(offset: Int) {
    let calendar = Calendar.current
    if let newMonth = calendar.date(byAdding: .month, value: offset, to: myPageDataManager.calendarDate) {
      self.myPageDataManager.calendarDate = newMonth
    }
  }
  
  private func calendarTitleFormat(date: Date) -> String {
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "yyyy년  M월"
    
    return dateFormatter.string(from: date)
  }
}

#Preview {
  MyPageCalendarView()
    .environmentObject(MyPageDataManager())
}
