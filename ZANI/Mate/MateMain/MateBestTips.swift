//
//  MateBestTips.swift
//  ZANI
//
//  Created by 강석호 on 2024/03/15.
//

import SwiftUI

struct MateBestTips: View {
    var body: some View {
        VStack(alignment: .leading) {
            Divider()
            HStack {
                VStack {
                    HStack {
                        Text("게시글 제목")
                            .foregroundColor(Color.white)
                            .padding(.top, 12)
                            .padding(.leading, 16)
                            .font(.system(size: 16))
                            .fontWeight(.medium)
                        
                        Spacer()
                    }
                    HStack {
                        Text("소개글이 대략 2줄정도만 보이도록?")
                            .foregroundColor(Color.white)
                            .padding(.leading, 16)
                            .font(.system(size: 14))
                            .fontWeight(.light)
                            .padding(.top, 16)
                        Spacer()
                    }
                    
                    HStack {
                        Text("💛 50")
                            .foregroundColor(Color.white)
                            .padding(.leading, 16)
                            .font(.system(size: 14))
                            .fontWeight(.light)
                            .padding(.top, 16)
                        Spacer()
                    }
                    
                    Spacer()
                }
                Rectangle()
                    .frame(width: 64, height: 64)
                    .clipShape(RoundedRectangle(cornerRadius: 20))
                    .padding(.trailing, 20)
            }
            
            
            Spacer()
            
        }
        .frame(height: 121)
        .background(Color.zaniMain1)
    }
}

#Preview {
    MateBestTips()
}
