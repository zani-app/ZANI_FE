//
//  ChangeNicknameView.swift
//  ZANI
//
//  Created by 정도현 on 3/20/24.
//

import SwiftUI
import PhotosUI

public struct ChangeNicknameView: View {
  @EnvironmentObject private var myPagePageManager: MyPagePageManager
  @EnvironmentObject private var myPageDataManager: MyPageDataManager
  
  @State private var userInput: String = ""
  
  @FocusState private var focusState
  
  public var userName: String
  
  public init(userName: String) {
    self.userName = userName
  }
  
  public var body: some View {
    VStack(spacing: 0) {
      navigationBar()
      
      profileImage()
      
      textField()
      
      Spacer()
      
      bottomButton()
    }
    .navigationBarBackButtonHidden()
    .onAppear {
      userInput = userName
    }
    .onChange(of: myPageDataManager.isSuccess, perform: { newValue in
      if newValue {
        myPagePageManager.pop()
      }
    })
    .onDisappear {
      myPageDataManager.deinitImageData()
    }
    .background(
      Color.main1
    )
  }
}

extension ChangeNicknameView {
  
  @ViewBuilder
  private func navigationBar() -> some View {
    ZaniNavigationBar(
      title: "닉네임 변경",
      leftAction: { myPagePageManager.pop() }
    )
  }
  
  @ViewBuilder
  private func profileImage() -> some View {
    if let userInfo = myPageDataManager.userInfo {
      PhotosPicker(selection: $myPageDataManager.selectedImage, matching: .images) {
        Group {
          if let imageData = myPageDataManager.selectedImageData, let image = UIImage(data: imageData) {
            Image(uiImage: image)
              .resizable()
              .aspectRatio(contentMode: .fill)
          } else {
            if userInfo.profileImageUrl != "" {
              AsyncImage(url: URL(string: userInfo.profileImageUrl)) { image in
                image.resizable()
                  .aspectRatio(contentMode: .fill)
              } placeholder: {
                ProgressView()
              }
            } else {
              Image("profileIcon")
                .resizable()
            }
          }
        }
        .frame(width: 98, height: 98)
      }
      .onChange(of: myPageDataManager.selectedImage) { newItem in
        Task {
          if let data = try? await newItem?.loadTransferable(type: Data.self) {
            myPageDataManager.selectedImageData = data
          }
        }
      }
      .clipShape(
        Circle()
      )
    } else {
      ProgressView()
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
  }
  
  @ViewBuilder
  private func textField() -> some View {
    VStack(alignment: .leading, spacing: 13) {
      Text("닉네임")
        .foregroundStyle(.white)
        .zaniFont(.body1)
      
      ZaniTextField(
        placeholderText: " 바꿀 닉네임을 작성해주세요.",
        placeholderTextStyle: .body1,
        keyboardType: .default,
        maximumInputCount: AuthTextFieldType.nickname.maximumInput,
        inputText: $userInput
      )
    }
    .padding(.top, 50)
    .padding(.horizontal, 20)
  }
  
  @ViewBuilder
  private func bottomButton() -> some View {
    ZaniMainButton(
      title: "수정 완료하기",
      isValid: myPageDataManager.changeNicknameButtonValidation(userInput: self.userInput),
      action: { myPageDataManager.checkNicnameValidation(nickname: self.userInput) }
    )
    .padding(.horizontal, 20)
    .padding(.bottom, 28)
  }
}

#Preview {
  ChangeNicknameView(userName: "test")
    .environmentObject(MyPagePageManager())
    .environmentObject(MyPageDataManager())
}
