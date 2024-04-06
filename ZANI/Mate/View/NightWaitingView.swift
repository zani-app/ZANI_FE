//
//  NightWaitingView.swift
//  ZANI
//
//  Created by 정도현 on 3/29/24.
//

import SwiftUI

public struct NightWaitingView: View {
  @EnvironmentObject private var nightMatePageManager: NightMatePageManager
  
  @State private var isShowMateList: Bool = false
  @State private var isTapUser: Bool = false
  
  public var body: some View {
    ZStack {
      VStack(spacing: 0) {
        ZaniNavigationBar(
          title: "",
          leftAction: { nightMatePageManager.pop() },
          rightIcon: Image("matesIcon"),
          rightAction: { withAnimation { isShowMateList = true } }
        )
        
        Image("backgroundCloud")
          .offset(x: -39)
        
        Spacer()
        
        bottomSheet()
      }
      
      NightMateListView(isTapUser: $isTapUser)
        .clipShape(
          RoundedRectangle(cornerRadius: 20)
        )
        .offset(x: isShowMateList ? 118 : UIScreen.main.bounds.width)
        .background(
          Color.black.opacity(isShowMateList ? 0.5 : 0.0)
            .ignoresSafeArea()
            .onTapGesture {
              withAnimation {
                isShowMateList = false
              }
            }
        )
      
      if isTapUser {
        ZStack {
          Color.black.opacity(0.5).ignoresSafeArea()
            .onTapGesture {
              isTapUser = false
            }
          
          NightUserDetailView()
            .padding(.horizontal, 50)
            .frame(maxHeight: .infinity)
        }
        
      }
    }
    .navigationBarBackButtonHidden()
    .background(
      VStack(spacing: 0) {
        LinearGradient(
          colors: [
            Color(red: 50/255, green: 34/255, blue: 105/255),
            Color(red: 37/255, green: 31/255, blue: 97/255)
          ],
          startPoint: .bottom,
          endPoint: .top
        )
        
        Color.main1
      }
        .ignoresSafeArea()
    )
  }
}

extension NightWaitingView {
  
  @ViewBuilder
  private func bottomSheet() -> some View {
    VStack(alignment: .leading, spacing: 0) {
      Text("현재 @명의 메이트들이 밤샘 진행중입니다!")
        .zaniFont(.title3)
        .foregroundStyle(.mainYellow)
        .padding(.bottom, 28)
      
      startButton()
        .padding(.bottom, 28)
      
      HStack(spacing: 17) {
        typeButton(type: .chatting)
          .onTapGesture {
            nightMatePageManager.push(.chatting)
          }
        
        typeButton(type: .timeline)
          .onTapGesture {
            nightMatePageManager.push(.timeline)
          }
      }
      .padding(.bottom, 22)
      
      nightGauge()
        .padding(.bottom, 17)
      
      caption()
    }
    .padding(.horizontal, 20)
    .padding(.top, 45)
    .padding(.bottom, 13)
    .background(
      Color.main1
    )
    .clipShape(.rect(topLeadingRadius: 30, topTrailingRadius: 30))
  }
  
  @ViewBuilder
  private func startButton() -> some View {
    Button(action: {
      
    }, label: {
      Text("밤샘 시작하기")
        .zaniFont(.title2)
        .foregroundStyle(.main1)
        .padding(.vertical, 14)
        .frame(maxWidth: .infinity)
        .background(
          RoundedRectangle(cornerRadius: 20)
            .fill(.mainYellow)
        )
    })
  }
  
  @ViewBuilder
  private func typeButton(type: NightDisplayType) -> some View {
    HStack(alignment: .top) {
      VStack(alignment: .leading, spacing: 8) {
        type.buttonIcon
        
        Text(type.rawValue)
          .zaniFont(.title2)
      }
      .foregroundStyle(.white)
      
      Spacer()
      
      Image("boxArrowIcon")
        .padding(.top, 9)
    }
    .padding(.leading, 20)
    .padding(.trailing, 16)
    .padding(.vertical, 12)
    .background(
      RoundedRectangle(cornerRadius: 10)
        .fill(
          LinearGradient(
            colors: [
              type.bottomGradientColor,
              type.topGradientColor
            ],
            startPoint: .bottom,
            endPoint: .top
          )
        )
    )
  }
  
  @ViewBuilder
  private func nightGauge() -> some View {
    VStack(alignment: .leading, spacing: 0) {
      Text("우리 크루의 밤샘 게이지")
        .zaniFont(.title2)
        .foregroundStyle(.mainYellow)
        .padding(.bottom, 16)
      
      ZStack(alignment: .leading) {
        Capsule()
          .fill(.main1)
          .frame(height: 30)
          .frame(maxWidth: .infinity)
        
        Capsule()
          .fill(
            LinearGradient(
              colors: [
                Color(red: 255/255, green: 180/255, blue: 0),
                  .mainYellow
              ],
              startPoint: .leading,
              endPoint: .trailing
            )
          )
          .frame(height: 30)
          .frame(width: 70)
      }
      .padding(.bottom, 6)
      
      HStack {
        Text("0%")
        
        Spacer()
        
        Text("100%")
      }
      .zaniFont(.body2).bold()
      .foregroundStyle(.white)
    }
    .padding(16)
    .background(
      RoundedRectangle(cornerRadius: 20)
        .fill(.main2)
    )
  }
  
  @ViewBuilder
  private func caption() -> some View {
    HStack(spacing: 8) {
      Spacer()
      
      Text("자니...? 진짜로 자니...?")
        .zaniFont(.body1)
        .foregroundStyle(.white)
        .padding(.horizontal, 16)
        .padding(.vertical, 8)
        .background(
          Color.main4
        )
        .clipShape(
          .rect(
            topLeadingRadius: 16,
            bottomLeadingRadius: 16,
            bottomTrailingRadius: 16,
            topTrailingRadius: 2
          )
        )
       
      Image("captionMoonIcon")
    }
  }
}

#Preview {
  NightWaitingView()
    .environmentObject(NightMatePageManager())
}
