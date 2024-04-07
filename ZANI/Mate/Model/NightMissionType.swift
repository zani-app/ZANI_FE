//
//  NightMissionType.swift
//  ZANI
//
//  Created by 정도현 on 4/7/24.
//

import Foundation
import SwiftUI

public enum NightMissionType: String {
  case imagination
  case drawImage
  case takePicture
  case multiply
  case balance
  
  public var missionDescription: String {
    switch self {
    case .imagination:
      return "상상력질문 미션"
    case .drawImage:
      return "그림그리기 미션"
    case .takePicture:
      return "사진찍기 미션"
    case .multiply:
      return "구구단 미션"
    case .balance:
      return "밸런스 게임"
    }
  }
  
  public var missionImage: Image {
    switch self {
    case .imagination:
      return Image("missionImagination")
    case .drawImage:
      return Image("missionDrawImage")
    case .takePicture:
      return Image("missionTakePicture")
    case .multiply:
      return Image("missionMultiply")
    case .balance:
      return Image("missionBalance")
    }
  }
}
