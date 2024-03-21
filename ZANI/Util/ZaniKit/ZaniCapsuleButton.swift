//
//  ZaniCapsuleButton.swift
//  ZANI
//
//  Created by 정도현 on 3/15/24.
//

import SwiftUI

public struct ZaniCapsuleButton: View {
  public var title: String
  public var isValid: Bool
  public var leadingIcon: Image?
  public var trailingIcon: Image?
  public var horizontalPadding: CGFloat
  public var action: () -> Void
  
  public init(
    title: String,
    isValid: Bool,
    leadingIcon: Image? = nil,
    trailingIcon: Image? = nil,
    horizontalPadding: CGFloat = 12,
    action: @escaping () -> Void
  ) {
    self.title = title
    self.isValid = isValid
    self.leadingIcon = leadingIcon
    self.trailingIcon = trailingIcon
    self.horizontalPadding = horizontalPadding
    self.action = action
  }
  
  public var body: some View {
    Button(action: {
      action()
    }, label: {
      HStack(alignment: .center, spacing: 0) {
        if let leadingIcon = leadingIcon {
          leadingIcon
            .renderingMode(.template)
            .padding(.trailing, 8)
        }
        
        Text(title)
        
        if let trailingIcon = trailingIcon {
          trailingIcon
            .renderingMode(.template)
            .padding(.leading, 4)
        }
      }
      .foregroundStyle(isValid ? Color.zaniMain2 : .white)
      .padding(.vertical, 6)
      .padding(.horizontal, horizontalPadding)
      .zaniFont(.body2)
      .background(
        Capsule()
          .stroke(isValid ? Color.zaniMain2 : .white, lineWidth: 1)
      )
    })
  }
}

#Preview {
  ZaniCapsuleButton(
    title: "test",
    isValid: true,
    horizontalPadding: 8, 
    action: { }
  )
}
