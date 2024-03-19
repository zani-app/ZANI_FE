//
//  AuthTextField.swift
//  ZANI
//
//  Created by 정도현 on 3/19/24.
//

import SwiftUI

public struct AuthTextField: View {
  public let fieldType: AuthTextFieldType
  public let textFormatValidation: (String) -> Bool
  public let maximumInputCount: Int
  public var focusState: FocusState<AuthTextFieldType?>.Binding
  
  @Binding var isVerified: Bool
  @Binding var inputText: String
  
  public init(
    fieldType: AuthTextFieldType,
    textFormatValidation: @escaping (String) -> Bool,
    maximumInputCount: Int,
    isVerified: Binding<Bool>,
    focusState: FocusState<AuthTextFieldType?>.Binding,
    inputText: Binding<String>
  ) {
    self.fieldType = fieldType
    self.textFormatValidation = textFormatValidation
    self.maximumInputCount = maximumInputCount
    self._isVerified = isVerified
    self.focusState = focusState
    self._inputText = inputText
  }
  
  public var body: some View {
    VStack(alignment: .leading, spacing: 16) {
      Text(fieldType.title)
        .zaniFont(.title2)
        .foregroundStyle(.main6)
      
      HStack(spacing: 10) {
        if fieldType == .password || fieldType == .passwordConfirm {
          SecureField("", text: $inputText)
            .placeholder(when: inputText.isEmpty, placeholder: {
              Text(" " + fieldType.placeholder)
                .zaniFont(.body1)
                .foregroundStyle(.main6)
            })
            .tint(Color.zaniMain2)
            .foregroundColor(focusState.wrappedValue == fieldType ? .white : .main6)
            .autocorrectionDisabled()
            .textInputAutocapitalization(.never)
            .keyboardType(fieldType.keyboardType)
            .focused(focusState, equals: fieldType)
        } else {
          TextField(
            "",
            text: $inputText
          )
          .placeholder(when: inputText.isEmpty, placeholder: {
            Text(" " + fieldType.placeholder)
              .zaniFont(.body1)
              .foregroundStyle(.main6)
          })
          .tint(Color.zaniMain2)
          .foregroundColor(focusState.wrappedValue == fieldType ? .white : .main6)
          .autocorrectionDisabled()
          .textInputAutocapitalization(.never)
          .keyboardType(fieldType.keyboardType)
          .focused(focusState, equals: fieldType)
        }
        
        if focusState.wrappedValue != fieldType && isVerified {
          Image("textfieldCheck")
        }
      }
      .onChange(of: inputText) { newValue in
        inputText = String(newValue.prefix(maximumInputCount))
        isVerified = textFormatValidation(inputText)
      }
      .padding(.vertical, 14)
      .padding(.horizontal, 13)
      .background(
        RoundedRectangle(cornerRadius: 8.0)
          .stroke(
            focusState.wrappedValue == fieldType ?
            inputText.isEmpty || isVerified ? .main2 : .errorRed :
            inputText.isEmpty || isVerified ? .main6 : .errorRed,
            lineWidth: 1
          )
          .foregroundStyle(.main1)
      )
      .onTapGesture {
        focusState.wrappedValue = fieldType
      }
      
      if !inputText.isEmpty && !textFormatValidation(inputText) {
        HStack(spacing: 8) {
          Image("textfieldAlertIcon")
          Text(fieldType.errorText)
          Spacer()
        }
        .zaniFont(.body2)
        .foregroundStyle(Color.errorRed)
      }
    }
  }
}

