//
//  MateAllNight.swift
//  ZANI
//
//  Created by 강석호 on 2024/03/15.
//

import SwiftUI

struct MateRoom: View {
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        ZStack {
            
            LinearGradient(colors: [Color(red: 37/255, green: 31/255, blue: 97/255), Color(red: 50/255, green: 34/255, blue: 105/255)], startPoint: .top, endPoint: .bottom)
                .edgesIgnoringSafeArea(.all)
            
            
            VStack {
                navigationBar()
                
                Image("CloudAllNight")
                    .offset(x: -39)
                
                ZStack {
                    RoundedRectangle(cornerRadius: 30)
                        .fill(Color.zaniMain1)
                        .padding(.horizontal, 8)
                    
                    
                    VStack(alignment: .leading) {
                        CountText()
                            .padding(.top, 35)
                            .padding(.leading, 20)
                        
                        StartButton()
                            .padding(.top, 15)
                            .padding(.horizontal, 20)
                        
                        TwoButtons()
                            .padding(.top, 15)
                            .padding(.horizontal, 20)
                        
                        Gauge()
                            .padding(.top, 0)
                            .padding(.horizontal, 20)
                        BottomMessage()
                        Spacer()
                    }
                    
                }
                .edgesIgnoringSafeArea(.bottom)
                
                
            }
            
            Spacer()
            
            
        }
    }
}

extension MateRoom {
    
    @ViewBuilder
    private func navigationBar() -> some View {
        NavBar(title: "")
    }
}

#Preview {
    MateRoom()
}
