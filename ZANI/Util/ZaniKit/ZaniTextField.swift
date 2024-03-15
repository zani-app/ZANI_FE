//
//  ZaniTextField.swift
//  ZANI
//
//  Created by 정도현 on 3/15/24.
//

import SwiftUI

public struct ZaniTextField: View {
  public let placeholderText: String
  public let isPlaceholderBold: Bool
  public let keyboardType: UIKeyboardType
  public let maximumInputCount: Int
  public let lineLimit: Int
  
  @Binding public var inputText: String
  
  public init(
    placeholderText: String,
    isPlaceholderBold: Bool = false,
    keyboardType: UIKeyboardType,
    maximumInputCount: Int,
    lineLimit: Int = 1,
    inputText: Binding<String>
  ) {
    self.placeholderText = placeholderText
    self.isPlaceholderBold = isPlaceholderBold
    self.keyboardType = keyboardType
    self.maximumInputCount = maximumInputCount
    self.lineLimit = lineLimit
    self._inputText = inputText
  }
  
  public var body: some View {
    TextField("", text: $inputText, axis: .vertical)
      .placeholder(when: inputText.isEmpty, placeholder: {
        Text(placeholderText)
          .zaniFont(isPlaceholderBold ? .title2 : .body1)
          .foregroundStyle(Color.zaniMain6)
      })
      .zaniFont(isPlaceholderBold ? .title2 : .body1)
      .tint(Color.zaniMain1)
      .foregroundColor(.white)
      .lineLimit(lineLimit, reservesSpace: true)
      .autocorrectionDisabled()
      .textInputAutocapitalization(.never)
      .keyboardType(keyboardType)
      .onChange(of: inputText) { newValue in
        inputText = String(newValue.prefix(maximumInputCount))
      }
      .padding(.vertical, 14)
      .padding(.horizontal, 16)
      .background(
        RoundedRectangle(cornerRadius: 10.0)
          .fill(Color(red: 35/255, green: 35/255, blue: 63/255))
      )
  }
}

#Preview {
  ZaniTextField(
    placeholderText: "test",
    keyboardType: .default,
    maximumInputCount: 3,
    inputText: .constant("test")
  )
}
