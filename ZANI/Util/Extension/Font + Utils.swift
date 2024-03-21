//
//  Font + Utils.swift
//  ZANI
//
//  Created by 정도현 on 3/15/24.
//

import SwiftUI

public enum ZaniFontType {
  case head2
  case head1
  case title1
  case title2
  case title3
  case body1
  case body2
  case body3
  case navi
}

// 깔끔하게 정리하기 보류
public extension View {
  func zaniFont(_ fontStyle: ZaniFontType) -> some View {
    switch fontStyle {
      
    case .head2:
      return AnyView(self
        .font(.custom("Pretendard-Bold", size: 36))
        .lineSpacing(7))
      
    case .head1:
      return AnyView(self
        .font(.custom("Pretendard-Bold", size: 28))
        .lineSpacing(16))
      
    case .title1:
      return AnyView(self
        .font(.custom("Pretendard-Bold", size: 20))
        .lineSpacing(4))
      
    case .title2:
      return AnyView(self
        .font(.custom("Pretendard-Bold", size: 16))
        .lineSpacing(3))
      
    case .title3:
      return AnyView(self
        .font(.custom("Pretendard-Bold", size: 18))
        .lineSpacing(6))
      
    case .body1:
      return AnyView(self
        .font(.custom("Pretendard-Regular", size: 16))
        .lineSpacing(3))
      
    case .body2:
      return AnyView(self
        .font(.custom("Pretendard-Regular", size: 14))
        .lineSpacing(3))
      
    case .body3:
      return AnyView(self
        .font(.custom("Pretendard-Bold", size: 14))
        .lineSpacing(3))
      
    case .navi:
      return AnyView(self
        .font(.custom("Pretendard-Regular", size: 12))
        .lineSpacing(4))
    }
  }
}
