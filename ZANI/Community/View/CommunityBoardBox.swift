//
//  CommunityBoardBox.swift
//  ZANI
//
//  Created by 정도현 on 3/31/24.
//

import SwiftUI

public struct CommunityBoardBox: View {
  public var body: some View {
    VStack(spacing: 8) {
      HStack(alignment: .top, spacing: 0) {
        VStack(alignment: .leading, spacing: 16) {
          Text("게시글 제목")
            .zaniFont(.title2)
          
          Text("게시글 내용 한 줄 미리보기")
            .zaniFont(.body2)
            .lineLimit(1)
        }
        .foregroundStyle(.white)
        
        Spacer()
        
        RoundedRectangle(cornerRadius: 10)
          .foregroundStyle(.black)
          .frame(width: 64, height: 64)
      }
      
      HStack(spacing: 4) {
        Image("heartIcon")
        
        Text("50")
          .zaniFont(.body2)
        
        Spacer()
      }
      .foregroundStyle(.mainGray)
    }
    .padding(20)
    .background(
      Color.main1
    )
  }
}

#Preview {
  CommunityBoardBox()
}
