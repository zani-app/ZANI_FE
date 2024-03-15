//
//  ZaniNavigationBar.swift
//  ZANI
//
//  Created by 정도현 on 3/15/24.
//

import SwiftUI

public struct ZaniNavigationBar: View {
  
  public var title: String
  public var leftAction: () -> Void
  
  public init(title: String, leftAction: @escaping () -> Void) {
    self.title = title
    self.leftAction = leftAction
  }
  
  public var body: some View {
    ZStack {
      HStack {
        Image(systemName: "chevron.left")
          .padding(12)
          .padding(.leading, 12)
          .onTapGesture {
            leftAction()
          }
        
        Spacer()
      }
      
      Text(title)
        .zaniFont(.title1)
    }
    .frame(maxWidth: .infinity)
    .padding(.vertical, 8)
    .foregroundStyle(.white)
  }
}

#Preview {
  VStack {
    ZaniNavigationBar(title: "test", leftAction: { })
  }
  .background(Color.zaniMain1)
}

