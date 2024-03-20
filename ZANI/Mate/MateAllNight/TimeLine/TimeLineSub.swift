//
//  TimeLine.swift
//  ZANI
//
//  Created by 강석호 on 2024/03/19.
//

import SwiftUI

struct TimeLineSub: View {
    var body: some View {
        HStack {
            VStack {
                ZStack {
                    RoundedRectangle(cornerRadius: 10)
                        .fill(Color.zaniMain2)
                        .frame(width: 50, height: 29)
                    
                    Text("22:30")
                        .foregroundColor(.black)
                        .fontWeight(.bold)
                        .font(.system(size: 16))
                }
                Spacer()
            }
            .padding(.leading, 20)
            
            VStack(spacing: 0){
                Image("Circle")
                    .padding(.top, 0)
                
                Rectangle()
                    .frame(width: 1, height: 105)
                    .foregroundColor(.gray)
            }
            .padding(.leading, 10)
            
            VStack {
                ZStack {
                    RoundedRectangle(cornerRadius: 10)
                        .fill(Color.zaniMain4)
                        .frame(width: 130, height: 39)
                    .padding(.leading, 20)
                    
                    Text("상상력질문 미션")
                        .foregroundColor(.white)
                        .padding(.leading, 14)
                        .fontWeight(.bold)
                        .font(.system(size: 16))
                }
                
                Spacer()
            }
            
            Spacer()
        }
        
        .frame(height: 121)
        .background(Color.zaniMain1)
        
    }
}

#Preview {
    TimeLineSub()
}
