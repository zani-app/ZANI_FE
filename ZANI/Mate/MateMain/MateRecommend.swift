//
//  MateRecommend.swift
//  ZANI
//
//  Created by 강석호 on 2024/03/15.
//

import SwiftUI

struct MateRecommend: View {
    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                Text("모집제목")
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
                    .padding(.top, 2)
                
                Spacer()
            }
            Spacer()
            
            HStack {
                // 밤샘시간
                Text("밤샘시간")
                    .foregroundColor(Color.white)
                    .padding(.leading, 16)
                    .font(.system(size: 14))
                    .fontWeight(.light)
                
                Text("12시간")
                    .foregroundColor(Color.white)
                    .padding(.leading, 1)
                    .font(.system(size: 14))
                    .fontWeight(.light)
                
                // 밤샘 유형
                Text("유형")
                    .foregroundColor(Color.white)
                    .padding(.leading, 16)
                    .font(.system(size: 14))
                    .fontWeight(.light)
                
                Text("시험공부")
                    .foregroundColor(Color.white)
                    .padding(.leading, 1)
                    .font(.system(size: 14))
                    .fontWeight(.light)
                
                // 인원
                Text("인원")
                    .foregroundColor(Color.white)
                    .padding(.leading, 16)
                    .font(.system(size: 14))
                    .fontWeight(.light)
                
                Text("4/4")
                    .foregroundColor(Color.white)
                    .padding(.leading, 3)
                    .font(.system(size: 14))
                    .fontWeight(.light)
            }
            .padding(.bottom, 15)
        }
        .frame(height: 121)
        .background(Color.zaniMain4)
    }
}

#Preview {
    MateRecommend()
}
