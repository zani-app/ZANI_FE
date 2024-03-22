//
//  NavBar.swift
//  ZANI
//
//  Created by 강석호 on 3/22/24.
//

import SwiftUI

public struct NavBar: View {
  
  public var title: String
  
  public init(title: String) {
    self.title = title
  }
  
  public var body: some View {
    ZStack {
      HStack {
        Image("BackArrow")
          .padding(12)
          .padding(.leading, 20)
          .onTapGesture {
          }
        
        Spacer()
          
          Image("Human")
            .padding(12)
            .padding(.trailing, 20)
            .onTapGesture {
            }
      }
      
        
    }
    .frame(maxWidth: .infinity)
    .padding(.vertical, 8)
    .foregroundStyle(.white)
  }
}

#Preview {
  VStack {
      NavBar(title: "test")
  }
  .background(Color.blue)
}

