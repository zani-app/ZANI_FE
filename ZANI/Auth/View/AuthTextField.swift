//
//  AuthTextField.swift
//  ZANI
//
//  Created by 정도현 on 3/19/24.
//

import SwiftUI

public struct AuthTextField: View {
  public let fieldType: AuthTextFieldType
  public let maximumInputCount: Int
  public let isValid: Bool
  public let isVerified: Bool
  
  public var focusState: FocusState<AuthTextFieldType?>.Binding
  
  @Binding var inputText: String
  
  public var body: some View {
    
    VStack(alignment: .leading, spacing: 16) {
      Text(fieldType.title)
        .zaniFont(.title2)
        .foregroundStyle(.main6)
      
      HStack(spacing: 10) {
        TextField("", text: $inputText)
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
          .onChange(of: inputText) { newValue in
            inputText = String(newValue.prefix(maximumInputCount))
          }
          .focused(focusState, equals: fieldType)
        
        if isVerified {
          Image("textfieldCheck")
        }
      }
      .padding(.vertical, 14)
      .padding(.horizontal, 13)
      .background(
        RoundedRectangle(cornerRadius: 8.0)
          .stroke(
            focusState.wrappedValue == fieldType ? .main2 :
                .main6,
            lineWidth: 1
          )
          .fill(.main1)
      )
      .onTapGesture {
        focusState.wrappedValue = fieldType
      }
      
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

extension AuthTextField {
  
}
