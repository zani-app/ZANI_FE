//
//  MoonLevel.swift
//  ZANI
//
//  Created by 정도현 on 3/20/24.
//

import SwiftUI

public enum MoonLevel: CaseIterable {
  case level1
  case level2
  case level3
  case level4
  
  public var description: String {
    switch self {
    case .level1:
      return "1~2시간"
    case .level2:
      return "3~5시간"
    case .level3:
      return "6~9시간"
    case .level4:
      return "10~12시간"
    }
  }
  
  public var moonImage: Image {
    switch self {
    case .level1:
      return Image("moon1")
    case .level2:
      return Image("moon2")
    case .level3:
      return Image("moon3")
    case .level4:
      return Image("moon4")
    }
  }
}
