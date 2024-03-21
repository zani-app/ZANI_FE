//
//  ZaniMainButton.swift
//  ZANI
//
//  Created by 정도현 on 3/15/24.
//

import SwiftUI

public struct ZaniMainButton: View {
  public var title: String
  public var isValid: Bool
  public var verticalPadding: CGFloat
  public var action: () -> Void
  
  public init(title: String, isValid: Bool, verticalPadding: CGFloat = 14, action: @escaping () -> Void) {
    self.title = title
    self.isValid = isValid
    self.verticalPadding = verticalPadding
    self.action = action
  }
  
  public var body: some View {
    Button(action: {
      action()
    }, label: {
      Text(title)
        .zaniFont(.title2)
        .foregroundStyle(Color.zaniMain1)
        .padding(.vertical, verticalPadding)
        .frame(maxWidth: .infinity)
        .background(
          RoundedRectangle(cornerRadius: 10.0)
            .fill(isValid ? Color.zaniMain2 : Color.zaniMain6)
        )
    })
    .disabled(!isValid)
  }
}
#Preview {
  ZaniMainButton(
    title: "test",
    isValid: false,
    verticalPadding: 12,
    action: {}
  )
}
