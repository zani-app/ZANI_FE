//
//  NetworkResult.swift
//  ZANI
//
//  Created by 정도현 on 3/22/24.
//

import Foundation

public enum NetworkResult<T> {
  case success(T)
  case requestErr(T)
  case pathErr
  case serverErr
  case networkFail
}
