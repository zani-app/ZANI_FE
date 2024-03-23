//
//  MateMain.swift
//  ZANI
//
//  Created by 정도현 on 3/14/24.
//

import SwiftUI

struct MateMain: View {
    @EnvironmentObject private var mateMainPageManager: MateMainPageManager
    
    var body: some View {
        NavigationStack(path: $mateMainPageManager.route) {
            ScrollView(showsIndicators: false) {
                VStack(spacing: 0) {
                    MateIntroduce()
                        .frame(height: 234)
                        .clipShape(RoundedRectangle(cornerRadius: 20))
                    
                        .padding(.top, 41)
                        .background(Color.zaniMain1)
                    Text("이런 밤샘 팀은 어때요?")
                        .foregroundColor(.white)
                        .fontWeight(.bold)
                        .font(.title3)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.top, 41)
                    
                    VStack(spacing: 10) {
                        ForEach(0 ... 2, id: \.self) { listing in
                            MateRecommend()
                                .frame(height: 121)
                                .clipShape(RoundedRectangle(cornerRadius: 20))
                        }
                    }
                    .padding(.top, 16)
                    .background(Color.zaniMain1)
                    
                    Text("지금 인기 있는 밤샘 꿀팁 게시글!")
                        .foregroundColor(.white)
                        .fontWeight(.bold)
                        .font(.title3)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.top, 52)
                    
                    VStack(spacing: 10) {
                        ForEach(0 ... 2, id: \.self) { listing in
                            MateBestTips()
                                .frame(height: 121)
                        }
                    }
                    .padding(.top, 10)
                    .background(Color.zaniMain1)
                }
                .background(Color.zaniMain1)
                .padding(.leading, 20)
                .padding(.trailing, 20)
                
            }
            .background(Color.zaniMain1)
            .navigationDestination(for: MateMainPageState.self) { pageState in
                mateMainPageDestination(pageState)
            }
            
        }
        
        .background(Color.zaniMain1)
    }
    
}

extension MateMain {
    
    @ViewBuilder
    private func mateMainPageDestination(_ type: MateMainPageState) -> some View {
        switch type {
        case .mateRoom:
            MateRoom()
                .toolbar(.hidden, for: .tabBar)
            
        case .chatting:
            MateListView()
                .toolbar(.hidden, for: .tabBar)
            
        case .timeLine:
            TimeLine()
                .toolbar(.hidden, for: .tabBar)
            
        default:
            RecruitmentMain()
        }
    }
}

#Preview {
    MateMain()
        .environmentObject(MateMainPageManager())
}