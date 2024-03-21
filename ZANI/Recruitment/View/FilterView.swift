//
//  FilterView.swift
//  ZANI
//
//  Created by 정도현 on 3/16/24.
//

import SwiftUI

public struct FilterView: View {
  @EnvironmentObject private var recruitmentPageManager: RecruitmentPageManager
  
  @State private var startTime: Int = 2
  @State private var endTime: Int = 12
  
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
      
      Text("\(startTime.description)시간 ~ \(endTime.description)시간")
        .zaniFont(.title1)
        .foregroundStyle(.white)
      
      ZStack(alignment: .leading) {
        Rectangle()
          .frame(height: 5)
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
          .offset(x: CGFloat(startTime - 2)/CGFloat(10) * (UIScreen.main.bounds.width - 58))
          .gesture(
            DragGesture(minimumDistance: 0)
              .onChanged { value in
                print(value.translation.width, "!!!")
                
                if value.translation.width > 0 {
                  let nextCoordinateValue = min(endTime - 1, startTime + Int(value.translation.width) * 10 /  Int(UIScreen.main.bounds.width - 58))
                  startTime = nextCoordinateValue
                } else {
                  let nextCoordinateValue = max(2, startTime + Int(value.translation.width))
                  startTime = nextCoordinateValue
                }
              }
          )
        
        Circle()
          .fill(.white)
          .frame(width: 12, height: 12)
          .overlay(
            Circle()
              .stroke(Color.zaniMain2, lineWidth: 6)
              .frame(width: 18, height: 18)
          )
          .offset(x: CGFloat(endTime - 2)/CGFloat(10) * (UIScreen.main.bounds.width - 58))
          .gesture(
            DragGesture(minimumDistance: 0)
              .onChanged { value in
                //                  print(value.translation.width, "!!!")
                //
                //                  if value.translation.width > 0 {
                //                    let nextCoordinateValue = max(12, endTime + Int(value.translation.width))
                //                    endTime = nextCoordinateValue
                //                  } else {
                //                    let nextCoordinateValue = min(startTime + 1, endTime + Int(value.translation.width) * 10 /  Int(UIScreen.main.bounds.width - 58))
                //                    endTime = nextCoordinateValue
                //
                //                  }
              }
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
              isValid: false,
              action: { }
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
        action: { }
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
  FilterView()
    .environmentObject(RecruitmentPageManager())
}
