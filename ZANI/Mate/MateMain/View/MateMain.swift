//
//  MateMain.swift
//  ZANI
//
//  Created by 정도현 on 3/14/24.
//

import SwiftUI

struct MateMain: View {
    @EnvironmentObject private var mateMainPageManager: MateMainPageManager
    
    let dummyData: [(title: String, introduction: String, nightTime: String, type: String, numberOfPeople: String)] = [
            ("중간고사 시험 대비", "중간고사 같이 공부해요~~! 모두 A+맞을 각오로 밤샘 할사람만 들어오기!!", "12시간", "시험대비", "4/5"),
            ("벚꽃톤 준비..", "벚꽃톤 프로젝트 같이 밤샐 사람 구합니다..^^", "8시간", "프로젝트", "3/5"),
            ("토익 시험 준비", "일요일에 있을 토익 시험 마지막 벼락치기 밤샘 할 사람!!! 같이 미션하면서 즐겁게 밤샘해요~~", "7시간", "시험대비", "2/5")
        ]
    
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
                        ForEach(dummyData.indices, id: \.self) { index in
                            MateRecommend(title: dummyData[index].title,
                                          introduction: dummyData[index].introduction,
                                          nightTime: dummyData[index].nightTime,
                                          type: dummyData[index].type,
                                          numberOfPeople: dummyData[index].numberOfPeople)
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
            ChattingMain()
                .toolbar(.hidden, for: .tabBar)
            
        case .timeLine:
            TimeLine()
                .toolbar(.hidden, for: .tabBar)
            
        case .mission:
            Mission()
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
