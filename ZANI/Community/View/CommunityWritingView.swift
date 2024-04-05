//
//  CommunityWritingView.swift
//  ZANI
//
//  Created by 정도현 on 3/31/24.
//

import PhotosUI
import SwiftUI

public struct CommunityWritingView: View {
  @EnvironmentObject private var communityPageManager: CommunityPageManager
  
  @State private var title: String = ""
  @State private var content: String = ""
  
  @State private var selectedPhotos = [PhotosPickerItem]()
  @State private var selectedImageData = [Data]()
  
  private let maxPhoto: Int = 3
  
  public var body: some View {
    VStack(spacing: 0) {
      ZaniNavigationBar(title: "글쓰기", leftAction: { communityPageManager.pop() })
        .padding(.bottom, 22)
      
      contents()
      
      Spacer()
      
      bottomButton()
    }
    .navigationBarBackButtonHidden()
    .background(
      .main1
    )
  }
}

extension CommunityWritingView {
  
  @ViewBuilder
  private func contents() -> some View {
    ScrollView {
      LazyVStack(alignment: .trailing, spacing: 11) {
        ZaniTextField(
          placeholderText: " 제목을 입력하세요",
          placeholderTextStyle: .body1,
          keyboardType: .default,
          maximumInputCount: 20,
          inputText: $title
        )
        
        ZaniTextField(
          placeholderText: " 여러분의 밤샘 꿀팁을 적어주세요!",
          placeholderTextStyle: .body1,
          keyboardType: .default,
          maximumInputCount: 200,
          lineLimit: 10,
          inputText: $content
        )
        
        Button(action: {
          
        }, label: {
          HStack(spacing: 8) {
            Image("cameraIcon")
            Text("사진 등록하기")
          }
          .zaniFont(.body2)
          .padding(8)
          .foregroundStyle(.mainGray)
          .background(
            RoundedRectangle(cornerRadius: 10)
              .stroke(Color.mainGray)
          )
        })
      }
      .padding(.horizontal, 20)
      .padding(.bottom, 20)
      
      imageSection()
    }
  }
  
  @ViewBuilder
  private func imageSection() -> some View {
    ScrollView(.horizontal, showsIndicators: false) {
      LazyHStack(spacing: 6) {
        PhotosPicker(
          selection: $selectedPhotos,
          maxSelectionCount: maxPhoto,
          selectionBehavior: .ordered,
          label: {
            HStack(spacing: 6) {
              VStack(spacing: 3) {
                Image(systemName: "plus")
                  .resizable()
                  .frame(width: 17, height: 17)
                  .padding(6)
                
                Text("사진 업로드")
                Text("(3/3)")
              }
              .zaniFont(.navi)
              .foregroundStyle(.white)
              .frame(width: 80, height: 80)
              .background(
                RoundedRectangle(cornerRadius: 10)
                  .fill(.main2)
              )
            }
          }
        )
        .tint(.main1)
        .onChange(of: self.selectedPhotos, perform: { value in
          self.selectedImageData = []
          
          for data in value {
            Task {
              if let imageData = try? await data.loadTransferable(type: Data.self) {
                selectedImageData.append(imageData)
              }
            }
          }
        })
        
        ForEach(self.selectedImageData, id: \.self) { image in
          if let uiImage = UIImage(data: image)  {
            Image(uiImage: uiImage)
              .resizable()
              .frame(width: 80, height: 80)
              .clipShape(RoundedRectangle(cornerRadius: 10))
          }
        }
      }
      .padding(.horizontal, 20)
    }
  }
  
  @ViewBuilder
  private func bottomButton() -> some View {
    ZaniMainButton(
      title: "글 등록하기",
      isValid: true,
      action: { }
    )
    .padding(.horizontal, 20)
    .padding(.vertical, 10)
  }
}

#Preview {
  CommunityWritingView()
    .environmentObject(CommunityPageManager())
}
