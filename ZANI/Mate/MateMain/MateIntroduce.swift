//
//  MateIntroduce.swift
//  ZANI
//
//  Created by 강석호 on 2024/03/15.
//

import SwiftUI

struct MateIntroduce: View {
    var body: some View {
        ZStack {
            // 배경색 설정
            Color(red: 37/255, green: 31/255, blue: 97/255)
                .edgesIgnoringSafeArea(.all)
            
            // 이미지 추가
            Image("CloudMain")
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: 200, height: 200)
                .padding()
            
            VStack(alignment: .leading) {
                HStack {
                    Text("밤샘메이트들과 함께 밤샘해요!\n문구가 두줄정도 들어가면 좋을것같은데..")
                        .foregroundColor(Color.white)
                        .padding(.top, 40)
                        .padding(.leading, 16)
                    
                    Spacer()
                }
                
                Spacer() // 두 요소 사이에 공간 추가
                
                // 버튼 추가
                HStack {
                    
                    Spacer()
                    
                    NavigationLink(destination: MateAllNight().navigationBarBackButtonHidden()) {
                        Text("밤샘 참여하기")
                            .font(.system(size: 14))
                            .foregroundColor(.black)
                            .padding(.horizontal, 15)
                            .padding(.vertical, 9)
                            .background(Color.zaniMain2)
                            .cornerRadius(20)
                    }
                }
                .padding(.bottom)
                .padding(.trailing, 16)
            }
        }
        .frame(height: 234)
    }
}

#Preview {
    MateIntroduce()
}
