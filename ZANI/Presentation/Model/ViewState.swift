//
//  ViewState.swift
//  ZANI
//
//  Created by 정도현 on 7/10/24.
//

import Foundation

public enum ViewState: Equatable {
  case loading
  case success
  case failure(errorDescription: String)
}
