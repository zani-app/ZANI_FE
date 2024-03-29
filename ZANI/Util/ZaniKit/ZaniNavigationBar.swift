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
  public var rightIcon: Image?
  public var rightAction: () -> Void
  
  public init(
    title: String,
    leftAction: @escaping () -> Void,
    rightIcon: Image? = nil,
    rightAction: @escaping () -> Void = { }
  ) {
    self.title = title
    self.leftAction = leftAction
    self.rightIcon = rightIcon
    self.rightAction = rightAction
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
        
        if let rightIcon = rightIcon {
          rightIcon
            .padding(12)
            .padding(.trailing, 12)
            .onTapGesture {
              rightAction()
            }
        }
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
    ZaniNavigationBar(title: "test", leftAction: { }, rightIcon: Image("matesIcon"))
  }
  .background(Color.main1)
}

