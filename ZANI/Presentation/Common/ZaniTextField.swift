//
//  ZaniTextField.swift
//  ZANI
//
//  Created by 정도현 on 3/15/24.
//

import SwiftUI

public struct ZaniTextField: View {
  public let placeholderText: String
  public let placeholderTextStyle: ZaniFontType
  public let placeHolderColor: Color
  public let textColor: Color
  public let backgroundColor: Color
  public let keyboardType: UIKeyboardType
  public let maximumInputCount: Int
  public let lineLimit: Int
  
  @Binding public var inputText: String
  
  public init(
    placeholderText: String,
    placeholderTextStyle: ZaniFontType,
    placeHolderColor: Color = Color(red: 189/255, green: 189/255, blue: 197/255),
    textColor: Color = .white,
    backgroundColor: Color = Color(red: 35/255, green: 35/255, blue: 63/255),
    keyboardType: UIKeyboardType,
    maximumInputCount: Int,
    lineLimit: Int = 1,
    inputText: Binding<String>
  ) {
    self.placeholderText = placeholderText
    self.placeholderTextStyle = placeholderTextStyle
    self.placeHolderColor = placeHolderColor
    self.textColor = textColor
    self.backgroundColor = backgroundColor
    self.keyboardType = keyboardType
    self.maximumInputCount = maximumInputCount
    self.lineLimit = lineLimit
    self._inputText = inputText
  }
  
  public var body: some View {
    TextField("", text: $inputText, axis: .vertical)
      .placeholder(when: inputText.isEmpty, placeholder: {
        Text(placeholderText)
          .zaniFont(placeholderTextStyle)
          .foregroundStyle(placeHolderColor)
      })
      .zaniFont(placeholderTextStyle)
      .tint(Color.main1)
      .foregroundColor(textColor)
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
          .fill(backgroundColor)
      )
  }
}

#Preview {
  ZaniTextField(
    placeholderText: "test",
    placeholderTextStyle: .body1,
    keyboardType: .default,
    maximumInputCount: 3,
    inputText: .constant("test")
  )
}
