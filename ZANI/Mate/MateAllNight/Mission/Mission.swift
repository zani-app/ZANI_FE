//
//  Mission.swift
//  ZANI
//
//  Created by 강석호 on 3/24/24.
//

import SwiftUI

struct Mission: View {
    @EnvironmentObject private var mateMainPageManager: MateMainPageManager
    @State private var textFieldText = "" // Text field input text
    var body: some View {
        
        
        ScrollView(showsIndicators: false) {
            
            navigationBar()
            VStack(alignment: .center, spacing: 0) {
                
                Text("바나나가 웃으면?")
                    .foregroundStyle(.white)
                    .font(.title)
                    .fontWeight(.bold)
                    .padding(.top, 150)
                    .background(Color.zaniMain1)
                
                TextField("Enter your answer", text: $textFieldText)
                    .padding()
                    .background(Color.white)
                    .cornerRadius(10)
                    .padding(.horizontal, 30)
                    .padding(.top, 150)
                
                Button(action: {
                }) {
                    Text("제출하기")
                    
                        .foregroundColor(.black)
                        .padding(.horizontal,50)
                        .frame(height: 50)
                        .background(Color.zaniMain2)
                        .cornerRadius(15)
                        .fontWeight(.bold)
                        .font(.title3)
                }
                .padding(.top, 120)
            }
            
        }
        .background(Color.zaniMain1)
        .navigationBarBackButtonHidden()
    }
}

extension Mission {
    
    @ViewBuilder
    private func navigationBar() -> some View {
        ZaniNavigationBar(title: "생존신고", leftAction: { mateMainPageManager.pop() })
    }
}

#Preview {
    Mission()
}
