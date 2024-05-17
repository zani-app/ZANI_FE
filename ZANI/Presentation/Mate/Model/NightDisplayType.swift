//
//  NightDisplayType.swift
//  ZANI
//
//  Created by 정도현 on 3/29/24.
//

import Foundation
import SwiftUI

public enum NightDisplayType: String {
  case chatting = "채팅"
  case timeline = "타임라인"
  
  public var buttonIcon: Image {
    switch self {
    case .chatting:
      return Image("chatIcon")
    case .timeline:
      return Image("timelineIcon")
    }
  }
  
  public var bottomGradientColor: Color {
    switch self {
    case .chatting:
      return Color(red: 255/255, green: 187/255, blue: 22/255)
    case .timeline:
      return Color(red: 153/255, green: 49/255, blue: 255/255)
    }
  }
  
  public var topGradientColor: Color {
    switch self {
    case .chatting:
      return Color.mainYellow
    case .timeline:
      return Color(red: 202/255, green: 160/255, blue: 243/255)
    }
  }
}
