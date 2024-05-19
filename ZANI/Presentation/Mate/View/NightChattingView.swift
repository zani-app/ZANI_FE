//
//  ChattingMain.swift
//  ZANI
//
//  Created by 정도현 on 3/24/24.
//

import SwiftUI

public struct NightChattingView: View {
  @EnvironmentObject private var nightMatePageManager: NightMatePageManager
  
  @ObservedObject private var chattingManager = ChattingManager()
  
  @State private var text: String = ""
  
  public var body: some View {
    VStack(spacing: 0) {
      ZaniNavigationBar(title: "채팅", leftAction: { nightMatePageManager.pop() })
      
      ScrollViewReader { proxy in
        ScrollView {
          if let chattingList = chattingManager.chatList, let nickname = chattingManager.nickname {
            var messageList = chattingList.messageList.reversed()
            
            VStack(spacing: 20) {
              ForEach(messageList.indices, id: \.self) { index in
                chatMessage(url: messageList[index].senderProfileImage, isMe: nickname == messageList[index].senderNickname, message: messageList[index].content)
                  .id(index)
              }
              .onAppear {
                proxy.scrollTo(messageList.count - 1, anchor: .bottom)
              }
            }
            .padding(.bottom, 20)
            .padding(.horizontal, 10)
          } else {
            ProgressView()
              .frame(maxWidth: .infinity, maxHeight: .infinity)
          }
        }
      }
      
      Spacer()
      
      HStack(spacing: 14) {
        ZaniTextField(
          placeholderText: " 메시지 보내기",
          placeholderTextStyle: .body1,
          keyboardType: .default,
          maximumInputCount: 50,
          inputText: $text
        )
        
        Button (action: {
          chattingManager.sendMessage(
            from: chattingManager.nickname!,
            to: "/app/chat/message/8",
            with: self.text
          )
          self.text = ""
        }, label: {
          Image(systemName: "airplane")
            .resizable()
            .frame(width: 24, height: 24)
            .padding(8)
            .background(
              Circle()
                .fill(.mainYellow)
            )
        })
      }
      .padding(.horizontal, 20)
      .padding(.bottom, 8)
    }
    .onAppear {
      chattingManager.connectStomp()
      chattingManager.requestUserInfo()
      chattingManager.requestChattingList(teamId: 8, page: 0, size: 50)
    }
    .background(
      Color.main1
    )
    .navigationBarBackButtonHidden()
  }
}

extension NightChattingView {
  
  @ViewBuilder
  private func chatMessage(url: String, isMe: Bool, message: String) -> some View {
    
    HStack(spacing: 10) {
      if isMe {
        Spacer()
      } else {
        AsyncImage(url: URL(string: url)) { image in
          image.resizable()
        } placeholder: {
          ProgressView()
        }
        .clipShape(
          Circle()
        )
        .aspectRatio(contentMode: .fit)
        .frame(height: 38)
      }
      
      Text(message)
        .zaniFont(.body1)
        .foregroundStyle(isMe ? .black : .white)
        .padding(.horizontal, 16)
        .padding(.vertical, 8)
        .background(
          RoundedRectangle(cornerRadius: 10)
            .fill(isMe ? .mainYellow : .main4)
        )
        .padding(
          isMe ? .leading : .trailing,
          80
        )
      
      if !isMe {
        Spacer()
      } else {
        AsyncImage(url: URL(string: url)) { image in
          image.resizable()
        } placeholder: {
          ProgressView()
        }
        .clipShape(
          Circle()
        )
        .aspectRatio(contentMode: .fit)
        .frame(height: 38)
      }
    }
  }
}

#Preview {
  NightChattingView()
    .environmentObject(NightMatePageManager())
}
