//
//  FilterView.swift
//  ZANI
//
//  Created by 정도현 on 3/16/24.
//

import SwiftUI

public struct FilterView: View {
  @EnvironmentObject private var recruitmentPageManager: RecruitmentPageManager
  @EnvironmentObject private var recruitmentManager: RecruitmentManager
  
  @State private var startTime: Int = 2
  @State private var endTime: Int = 12
  
  @State private var startTimeBuffer: Int = 2
  @State private var endTimeBuffer: Int = 12
  
  @State private var categoryBuffer: String
  @State private var isPublicBuffer: Bool
  @State private var isEmptyBuffer: Bool
  
  public init(categoryBuffer: String, isPublicBuffer: Bool, isEmptyBuffer: Bool) {
    self.categoryBuffer = categoryBuffer
    self.isPublicBuffer = isPublicBuffer
    self.isEmptyBuffer = isEmptyBuffer
  }
  
  public var body: some View {
    VStack(spacing: 0) {
      navigationBar()
      
      ScrollView {
        nightTimeIndicator()
        
        ForEach(FilterCategory.allCases, id: \.self) { type in
          categoryBox(type: type)
        }
        
        Spacer()
      }
      
      bottomButton()
    }
    .navigationBarBackButtonHidden()
    .background(
      Color.zaniMain1
    )
  }
}

extension FilterView {
  
  @ViewBuilder
  private func navigationBar() -> some View {
    ZaniNavigationBar(
      title: "필터",
      leftAction: { recruitmentPageManager.pop() }
    )
  }
  
  @ViewBuilder
  private func nightTimeIndicator() -> some View {
    VStack(alignment: .leading, spacing: 30) {
      Text("밤샘시간")
        .zaniFont(.title2)
        .foregroundStyle(.white)
      
      Text("\(startTimeBuffer.description)시간 ~ \(endTimeBuffer.description)시간")
        .zaniFont(.title1)
        .foregroundStyle(.white)
      
      ZStack(alignment: .leading) {
        Rectangle()
          .frame(height: 5)
          .foregroundStyle(.white)
          .padding(.horizontal, 9)
        
        Rectangle()
          .frame(
            width: CGFloat((endTimeBuffer - startTimeBuffer)) * (UIScreen.main.bounds.width - 58) / CGFloat(10),
            height: 5
          )
          .offset(x: CGFloat(startTimeBuffer - 2) * (UIScreen.main.bounds.width - 58) / CGFloat(10))
          .foregroundStyle(.main2)
          .padding(.horizontal, 9)
        
        Circle()
          .fill(.white)
          .frame(width: 12, height: 12)
          .overlay(
            Circle()
              .stroke(Color.zaniMain2, lineWidth: 6)
              .frame(width: 18, height: 18)
          )
          .offset(x: CGFloat(startTimeBuffer - 2) * ((UIScreen.main.bounds.width - 58) / CGFloat(10)))
          .gesture(
            DragGesture(minimumDistance: ((UIScreen.main.bounds.width - 58) / CGFloat(10)))
              .onChanged { value in
                if value.translation.width > 0 {
                  let nextCoordinateValue = min(
                    endTimeBuffer - 1,
                    startTime + Int(round(value.translation.width / (UIScreen.main.bounds.width - 58) * 10))
                  )
                  
                  startTimeBuffer = nextCoordinateValue
                } else {
                  let nextCoordinateValue = max(
                    2,
                    startTime + Int(round(value.translation.width / (UIScreen.main.bounds.width - 58) * 10))
                  )
                  startTimeBuffer = nextCoordinateValue
                }
              }
              .onEnded({ value in
                startTime = startTimeBuffer
              })
          )
        
        Circle()
          .fill(.white)
          .frame(width: 12, height: 12)
          .overlay(
            Circle()
              .stroke(Color.zaniMain2, lineWidth: 6)
              .frame(width: 18, height: 18)
          )
          .offset(x: CGFloat(endTimeBuffer - 2)/CGFloat(10) * (UIScreen.main.bounds.width - 58))
          .gesture(
            DragGesture(minimumDistance: ((UIScreen.main.bounds.width - 58) / CGFloat(10)))
              .onChanged { value in
                if value.translation.width > 0 {
                  let nextCoordinateValue = min(
                    12,
                    endTime + Int(round(value.translation.width / (UIScreen.main.bounds.width - 58) * 10))
                  )
                  
                  endTimeBuffer = nextCoordinateValue
                } else {
                  let nextCoordinateValue = max(
                    startTimeBuffer + 1,
                    endTime + Int(round(value.translation.width / (UIScreen.main.bounds.width - 58) * 10))
                  )
                  
                  endTimeBuffer = nextCoordinateValue
                }
              }
              .onEnded({ value in
                endTime = endTimeBuffer
              })
          )
      }
      .frame(maxWidth: .infinity)
    }
    .padding(.horizontal, 20)
    .padding(.top, 16)
    .padding(.bottom, 36)
  }
  
  @ViewBuilder
  private func categoryBox(type: FilterCategory) -> some View {
    VStack(spacing: 0) {
      divider()
      
      VStack(alignment: .leading, spacing: 28) {
        Text(type.title)
          .zaniFont(.title2)
          .foregroundStyle(.white)
        
        HStack(spacing: 6) {
          ForEach(type.filterList, id: \.self) { filter in
            ZaniCapsuleButton(
              title: filter,
              isValid:
                type == .roomType ? self.categoryBuffer == filter : type == .isEmptySeat ? self.isEmptyBuffer : self.isPublicBuffer
              ,
              action: {
                switch type {
                case .roomType:
                  if self.categoryBuffer == filter {
                    self.categoryBuffer = ""
                  } else {
                    self.categoryBuffer = filter
                  }
                case .isEmptySeat:
                  self.isEmptyBuffer.toggle()
                case .isOpenRoom:
                  self.isPublicBuffer.toggle()
                }
              }
            )
          }
          
          Spacer()
        }
      }
      .padding(.vertical, 30)
      .padding(.horizontal, 20)
    }
  }  
  
  @ViewBuilder
  private func bottomButton() -> some View {
    HStack(spacing: 9) {
      Button(action: {
        self.categoryBuffer = ""
        self.isEmptyBuffer = false
        self.isPublicBuffer = true
        self.startTime = 2
        self.endTime = 12
        self.startTimeBuffer = 2
        self.endTimeBuffer = 12
      }, label: {
        HStack(spacing: 6) {
          Image("initArrow")
          Text("초기화")
        }
        .zaniFont(.body1)
        .foregroundStyle(.white)
        .padding(.vertical, 10)
        .frame(maxWidth: .infinity)
        .background(
          RoundedRectangle(cornerRadius: 10)
            .fill(Color.zaniMain4)
        )
      })
      
      ZaniMainButton(
        title: "적용하기",
        isValid: true,
        verticalPadding: 10,
        action: { 
          recruitmentManager.category = self.categoryBuffer
          recruitmentManager.isEmpty = self.isEmptyBuffer
          recruitmentManager.isPublic = self.isPublicBuffer
          recruitmentPageManager.pop()
        }
      )
    }
    .padding(.horizontal, 20)
    .padding(.vertical, 14)
  }
  
  @ViewBuilder
  private func divider() -> some View {
    Divider()
      .frame(height: 2)
      .overlay(Color(red: 35/255, green: 35/255, blue: 63/255))
  }
}

#Preview {
  FilterView(categoryBuffer: "test", isPublicBuffer: false, isEmptyBuffer: false)
    .environmentObject(RecruitmentPageManager())
    .environmentObject(RecruitmentManager())
}
