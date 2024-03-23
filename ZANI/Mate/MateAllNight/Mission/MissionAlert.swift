//
//  MissionAlert.swift
//  ZANI
//
//  Created by 강석호 on 3/24/24.
//

import SwiftUI

struct MissionAlert: View {
    
    @EnvironmentObject private var mateMainPageManager: MateMainPageManager
    @State private var remainingTime = 120 // Initial time in seconds
    let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect() // Timer to decrement remaining time
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 25)
                .fill(Color.zaniMain4)
            
            VStack {
                Text("생존신고하기!")
                    .padding(.top, 20)
                    .foregroundColor(.white)
                    .font(.title)
                    .fontWeight(.bold)
                
                Image("Mission")
                    .padding(.top, 5)
                Text("상상력 질문 미션")
                    .foregroundColor(.white)
                    .fontWeight(.bold)
                    .font(.title3)
                    .padding(.top, 5)
                
                Text("\(formatTime(remainingTime))")
                    .foregroundColor(.white)
                    .padding(.top, 3)
                    .font(.title3)
                    .fontWeight(.bold)
                
                VStack {
                    Text("수락하기")
                    
                        .foregroundColor(.black)
                        .padding(.horizontal,40)
                        .frame(height: 40)
                        .background(Color.zaniMain2)
                        .cornerRadius(20)
                        .fontWeight(.bold)
                }
                .padding(.top, 5)
                .onTapGesture {
                    mateMainPageManager.push(.mission)
                }
                
                
                Button(action: {
                }) {
                    Text("보류하기")
                    
                        .foregroundColor(.white)
                        .padding(.horizontal,40)
                        .frame(height: 40)
                        .background(.red)
                        .cornerRadius(20)
                        .fontWeight(.bold)
                }
                .padding(.top, 3)
                
                Spacer()
                
            }
        }
        .padding(.horizontal, 60)
        .padding(.vertical, 170)
        .onReceive(timer) { _ in
            if remainingTime > 0 {
                remainingTime -= 1
            } else {
                timer.upstream.connect().cancel()
            }
        }
    }
    // Helper function to format time in MM:SS format
    func formatTime(_ time: Int) -> String {
        let minutes = time / 60
        let seconds = time % 60
        return String(format: "%02d:%02d", minutes, seconds)
    }
}

#Preview {
    MissionAlert()
}
