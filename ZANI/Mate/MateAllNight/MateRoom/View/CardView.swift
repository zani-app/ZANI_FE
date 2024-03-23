//
//  CardView.swift
//  ZANI
//
//  Created by 강석호 on 3/24/24.
//

import SwiftUI

struct CardView: View {
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 25)
                .fill(Color.zaniMain4)
                
            VStack {
                Image("Avatar")
                    .padding(.top, 40)
                
                Text("사용자 이름")
                    .padding(.top, 10)
                    .foregroundColor(.white)
                    .font(.title)
                Text("잠만보")
                    .foregroundColor(.green)
                
                Button(action: {
                }) {
                    Text("팔로우")
                        
                        .foregroundColor(.black)
                        .padding(.horizontal,40)
                        .frame(height: 40)
                        .background(Color.zaniMain2)
                        .cornerRadius(20)
                        .fontWeight(.bold)
                }
                .padding(.top, 10)
                
                Spacer()
                
            }
        }
        .padding(.horizontal, 60)
        .padding(.vertical, 220)
    }
}

#Preview {
    CardView()
}
