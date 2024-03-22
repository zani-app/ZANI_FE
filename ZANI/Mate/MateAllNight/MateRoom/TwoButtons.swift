//
//  TwoButtons.swift
//  ZANI
//
//  Created by 강석호 on 3/22/24.
//

import SwiftUI

struct TwoButtons: View {
    var body: some View {
        HStack(alignment: .center, spacing: 17) {
            
            // 채팅 버튼
            Button(action: {
            }) {
                VStack(alignment: .leading) {
                    HStack {
                        Image("Message")
                            .padding(.leading, 20)
                        
                        Image("NextButton")
                            .padding(.leading, 50)
                            .padding(.trailing, 16)
                    }
                    .padding(.top, 12)
                    
                    HStack {
                        Text("채팅")
                            .padding(.leading, 20)
                            .padding(.bottom,12)
                            .font(.title2)
                            .foregroundColor(.white)
                    }
                }
                
            }
            .background(LinearGradient(colors: [Color(red: 255/255, green: 211/255, blue: 105/255), Color(red: 255/255, green: 187/255, blue: 22/255)], startPoint: .top, endPoint: .bottom))
            .cornerRadius(10)
            
            // 타임라인 버튼
            NavigationLink(destination: TimeLine()) {
                VStack(alignment: .leading) {
                    HStack {
                        Image("TimeLine")
                            .padding(.leading, 20)
                        
                        Image("NextButton")
                            .padding(.leading, 50)
                            .padding(.trailing, 16)
                    }
                    .padding(.top, 12)
                    
                    HStack {
                        Text("타임라인")
                            .padding(.leading, 20)
                            .padding(.bottom,12)
                            .font(.title2)
                            .foregroundColor(.white)
                    }
                }
                
            }
            .background(LinearGradient(colors: [Color(red: 202/255, green: 160/255, blue: 243/255), Color(red: 153/255, green: 49/255, blue: 255/255)], startPoint: .top, endPoint: .bottom))
            .cornerRadius(10)
        }
    }
}

#Preview {
    TwoButtons()
}
