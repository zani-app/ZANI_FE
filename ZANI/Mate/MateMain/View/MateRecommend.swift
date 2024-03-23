//
//  MateRecommend.swift
//  ZANI
//
//  Created by 강석호 on 2024/03/15.
//
//

import SwiftUI

import SwiftUI

struct MateRecommend: View {
    let title: String
    let introduction: String
    let nightTime: String
    let type: String
    let numberOfPeople: String
    
    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                Text(title)
                    .foregroundColor(Color.white)
                    .padding(.top, 12)
                    .padding(.leading, 16)
                    .font(.system(size: 16))
                    .fontWeight(.medium)
                
                Spacer()
            }
            
            HStack {
                Text(introduction)
                    .foregroundColor(Color.white)
                    .lineLimit(2) // Limit to 2 lines
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
                
                Text(nightTime)
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
                
                Text(type)
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
                
                Text(numberOfPeople)
                    .foregroundColor(Color.white)
                    .padding(.leading, 3)
                    .font(.system(size: 14))
                    .fontWeight(.light)
            }
            .padding(.bottom, 15)
        }
        .frame(height: 121)
        .background(Color.zaniMain4)
        .cornerRadius(20)
    }
}

#Preview {
    MateRecommend(title: "모집제목", introduction: "소개글이 대략 2줄정도만 보이도록?", nightTime: "12시간", type: "시험공부", numberOfPeople: "4/4")
}
