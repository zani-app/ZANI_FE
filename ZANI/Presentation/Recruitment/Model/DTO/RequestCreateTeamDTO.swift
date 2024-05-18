//
//  RequestCreateTeamDTO.swift
//  ZANI
//
//  Created by 정도현 on 5/18/24.
//

import SwiftUI

public struct RequestCreateTeamDTO: Hashable {
  public var title: String
  public var maxNum: Int
  public var targetTime: Int
  public var password: String
  public var category: String
  public var description: String
  public var secret: Bool
}
