//
//  LoadingIndicatorModifier.swift
//  ZANI
//
//  Created by 정도현 on 7/10/24.
//

import SwiftUI

public struct LoadingIndicatorModifier: AnimatableModifier {
  public let isLoading: Bool
  
  public init(
    isLoading: Bool
  ) {
    self.isLoading = isLoading
  }
  
  public func body(content: Content) -> some View {
    ZStack {
      if isLoading {
        ZStack(alignment: .center) {
          content
            .disabled(self.isLoading)
            .blur(radius: self.isLoading ? 2 : 0)
          
          ProgressView()
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(.black.opacity(0.3))
            .opacity(self.isLoading ? 1 : 0)
        }
      } else {
        content
      }
    }
  }
}

extension View {
  
  func loadingView(isLoading: Bool) -> some View {
    modifier(
      LoadingIndicatorModifier(isLoading: isLoading)
    )
  }
}
