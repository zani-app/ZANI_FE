//
//  MyPageCalendarView.swift
//  ZANI
//
//  Created by 정도현 on 3/20/24.
//

import SwiftUI

public struct MyPageCalendarView: View {
  @State var date: Date = .now
  @State var offset: CGSize = CGSize()
  
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
        .fill(Color.main7)
        .frame(height: 375)
    )
    .frame(height: 375)
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
        
        Text(calendarTitleFormat(date: date))
        
        Image(systemName: "chevron.right")
          .frame(width: 24, height: 24)
          .onTapGesture {
            if getMonth(date: .now) > getMonth(date: self.date) {
              moveMonth(offset: 1)
            }
          }
          .foregroundStyle(getMonth(date: .now) > getMonth(date: self.date) ? .white : Color.main6)
      }
      .font(.custom("Pretendard-Bold", size: 18))
      .lineSpacing(2)
      .padding(.bottom, 23)
    }
    .foregroundStyle(.white)
  }
  
  private func calendarContents() -> some View {
    let daysInMonth: Int = numberOfDays(in: date)
    let firstWeekday: Int = firstWeekdayOfMonth(in: date) - 1
    
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
            
            dateView(day: day, isNight: true)
          }
        }
      }
      .padding(.horizontal, 18)
    }
  }
  
  public func dateView(day: Int, isNight: Bool) -> some View {
    ZStack(alignment: .center) {
      Rectangle()
        .frame(width: 40, height: 40)
        .opacity(0)
      
      if day < 7 {
        Image("moon1")
          .resizable()
          .frame(width: 40, height: 40)
      } else if day < 14 {
        Image("moon2")
          .resizable()
          .frame(width: 40, height: 40)
      } else if day < 21 {
        Image("moon3")
          .resizable()
          .frame(width: 40, height: 40)
      } else {
        Image("moon4")
          .resizable()
          .frame(width: 40, height: 40)
      }
      
      Text(String(day))
        .font(.custom("Pretendard-Regular", size: 20))
        .lineSpacing(5)
        .foregroundStyle(isNight ? .black : .white)
    }
  }
}

extension MyPageCalendarView {
  
  private func startOfMonth() -> Date {
    let components = Calendar.current.dateComponents(
      [.year, .month],
      from: date
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
    if let newMonth = calendar.date(byAdding: .month, value: offset, to: date) {
      self.date = newMonth
    }
  }
  
  private func calendarTitleFormat(date: Date) -> String {
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "yyyy년  M월"
    
    return dateFormatter.string(from: date)
  }
  
  func getMonth(date: Date) -> Int {
    let calendar = Calendar.current
    let month = calendar.component(.month, from: date)
    return month
  }
}

#Preview {
  MyPageCalendarView()
}
