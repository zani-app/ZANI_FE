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
  
  @State private var type: [String] = [""]
  @State private var isEmptySeat: Bool = false
  @State private var isPrivateRoom: Bool = false
  
  public var body: some View {
    VStack(spacing: 0) {
      ZaniNavigationBar(title: "필터", leftAction: { recruitmentPageManager.pop() })
      
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
      
      Spacer()
    }
    .navigationBarBackButtonHidden()
    .background(
      Color.zaniMain1
    )
  }
}

#Preview {
  FilterView()
    .environmentObject(RecruitmentPageManager())
}
