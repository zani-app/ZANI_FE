//
//  ZaniMainButton.swift
//  ZANI
//
//  Created by 정도현 on 3/15/24.
//

import SwiftUI

public struct ZaniMainButton: View {
  public var title: String
  public var titleColor: Color
  public var backgroundColor: Color
  public var action: () -> Void
  
  public init(title: String, titleColor: Color, backgroundColor: Color, action: @escaping () -> Void) {
    self.title = title
    self.titleColor = titleColor
    self.backgroundColor = backgroundColor
    self.action = action
  }
  
  public var body: some View {
    Button(action: {
      action()
    }, label: {
      Text(title)
        .zaniFont(.title2)
        .foregroundStyle(titleColor)
        .padding(.vertical, 14)
        .frame(maxWidth: .infinity)
        .background(
          RoundedRectangle(cornerRadius: 10.0)
            .fill(backgroundColor)
        )
    })
  }
}
#Preview {
  ZaniMainButton(title: "test", titleColor: .main1, backgroundColor: .main2, action: {})
}
