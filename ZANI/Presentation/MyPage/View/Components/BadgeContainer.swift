//
//  BadgeContainer.swift
//  ZANI
//
//  Created by 정도현 on 5/18/24.
//

import SwiftUI

public struct BadgeDTO {
  public let title: String
  public let condition: String
  public let isLock: Bool
}

public struct BadgeContainer: View {
  
  public let badgeData: BadgeDTO
  
  public var body: some View {
    HStack {
      VStack(alignment: .leading, spacing: 13) {
        Text(badgeData.title)
          .zaniFont(.title2)
          .foregroundStyle(.yellow1)
          
        Text("획들 조건: \(badgeData.condition)")
          .zaniFont(.body2)
          .foregroundStyle(.white)
      }
      
      Spacer()
      
      if badgeData.isLock {
        Image("lockIcon")
      }
    }
    .padding(16)
    .background(
      RoundedRectangle(cornerRadius: 10)
        .fill(.main2)
    )
    .padding(.horizontal, 20)
  }
}

#Preview {
  BadgeContainer(
    badgeData: BadgeDTO(
      title: "test", 
      condition: "test",
      isLock: true
    )
  )
}
