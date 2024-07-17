//
//  RequestTeamListDTO.swift
//  ZANI
//
//  Created by 정도현 on 5/18/24.
//

import SwiftUI

public struct RequestTeamListDTO: Hashable {
  public var keyword: String
  public var category: String
  public var isEmpty: Bool
  public var isSecret: Bool
  public var page: Int
  public var size: Int
}
