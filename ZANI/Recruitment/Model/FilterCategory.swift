//
//  FilterCategory.swift
//  ZANI
//
//  Created by 정도현 on 3/19/24.
//

import Foundation

public enum FilterCategory: CaseIterable {
  case roomType
  case isEmptySeat
  case isSecretRoom
  
  public var title: String {
    switch self {
    case .roomType:
      return "유형"
    case .isEmptySeat:
      return "빈 자리 유무"
    case .isSecretRoom:
      return "비공개방 유무"
    }
  }
  
  public var filterList: [String] {
    switch self {
    case .roomType:
      return ["시험대비", "프로젝트", "과제"]
    case .isEmptySeat:
      return ["빈자리 있음"]
    case .isSecretRoom:
      return ["비공개방"]
    }
  }
}
