//
//  View + Loading.swift
//  ZANI
//
//  Created by 정도현 on 7/10/24.
//

import SwiftUI

extension View {
  
  func loadingView(isLoading: Bool) -> some View {
    modifier(
      LoadingIndicatorModifier(isLoading: isLoading)
    )
  }
}
