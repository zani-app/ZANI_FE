//
//  CreateTeamSection.swift
//  ZANI
//
//  Created by 정도현 on 3/16/24.
//

import Foundation

public enum CreateTeamSection: CaseIterable {
  case category
  case peopleCount
  case nightTime
  
  public var title: String {
    switch self {
    case .category:
      return "카테고리"
      
    case .peopleCount:
      return "모집 인원"
      
    case .nightTime:
      return "밤샘시간"
    }
  }
  
  public var selectOptions: [String] {
    switch self {
    case .category:
      return ["시험대비", "프로젝트", "과제"]
      
    case .peopleCount:
      return Array(1...10).map { String($0) }
      
    case .nightTime:
      return Array(2...12).map { String($0) }
    }
  }
  
  public var countUnit: String {
    switch self {
    case .category:
      return ""
      
    case .peopleCount:
      return "명"
      
    case .nightTime:
      return  "시간"
    }
  }
}
