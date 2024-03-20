//
//  MateAllNight.swift
//  ZANI
//
//  Created by 강석호 on 2024/03/15.
//

import SwiftUI

struct MateAllNight: View {
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        ZStack {
            
            LinearGradient(colors: [Color(red: 37/255, green: 31/255, blue: 97/255), Color(red: 50/255, green: 34/255, blue: 105/255)], startPoint: .top, endPoint: .bottom)
            
            VStack {
                
                ZStack(alignment: .topTrailing) {
                    Image("CloudAllNight")
                        .padding(.top,91)
                        .offset(x: -39)
                    
                    HStack {
                        Button {
                            dismiss()
                        } label: {
                            Image(systemName: "chevron.left")
                                .foregroundColor(.black)
                                .background {
                                    Circle()
                                        .fill(.white)
                                        .frame(width: 32, height: 32)
                                }
                                .padding()
                        }
                        .padding(.top, 60)
                        .padding(.leading, 30)
                        
                        Spacer()
                        
                        //사이드 메뉴바
                        Button {
                            
                        } label: {
                            Image(systemName: "line.horizontal.3")
                                .foregroundColor(.black)
                                .background {
                                    Circle()
                                        .fill(.white)
                                        .frame(width: 32, height: 32)
                                }
                                .padding()
                        }
                        .padding(.top, 60)
                        .padding(.trailing, 30)
                        
                    }
                }
                
                ZStack {
                    
                    RoundedRectangle(cornerRadius: 30)
                        .fill(Color.zaniMain1)
                        .edgesIgnoringSafeArea(.all)
                    
                    VStack(alignment: .leading) {
                        HStack {
                            Text("현재 @명의 메이트들이 밤샘 진행중입니다!")
                                .foregroundColor(Color.zaniMain2)
                                .fontWeight(.bold)
                                .font(.system(size: 18))
                            Spacer()
                        }
                        .padding(.top, 45)
                        
                        
                        Button(action: {
                        }) {
                            Text("밤샘 시작하기")
                                .frame(maxWidth: .infinity)
                                .foregroundColor(.black)
                                .padding()
                                .background(Color.zaniMain2)
                                .cornerRadius(20)
                                .fontWeight(.bold)
                        }
                        .padding(.top, 28)
                        
                        HStack(alignment: .center,spacing: 17) {
                            
                            // 채팅 버튼
                            Button(action: {
                            }) {
                                VStack(alignment: .leading,spacing: 8) {
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
                                VStack(alignment: .leading,spacing: 8) {
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
                        .padding(.top, 28)
                        
                        ZStack {
                            RoundedRectangle(cornerRadius: 30)
                                .fill(Color.zaniMain4)
                                .padding(.top, 22)
                                .frame(height: 159)
                            VStack {
                                HStack {
                                    Text("우리 크루의 밤샘 게이지")
                                        .foregroundColor(Color.zaniMain2)
                                        .fontWeight(.bold)
                                        .font(.system(size: 18))
                                        .padding(.leading, 18)
                                        .padding(.top, 16)
                                    Spacer()
                                }
                                ZStack(alignment: .leading) {
                                    RoundedRectangle(cornerRadius: 10)
                                        .frame(height: 30)
                                        .foregroundColor(Color.zaniMain1)
                                    
                                    
                                    RoundedRectangle(cornerRadius: 10)
                                        .frame(width: 120, height: 30)
                                        .foregroundColor(Color.yellow)
                                }
                                .padding(.horizontal,20)
                                .padding(.top, 10)
                                
                                HStack {
                                    Text("0%")
                                        .foregroundColor(Color.white)
                                        .fontWeight(.bold)
                                        .font(.system(size: 18))
                                        .padding(.leading, 18)
                                    Spacer()
                                    Text("100%")
                                        .foregroundColor(Color.white)
                                        .fontWeight(.bold)
                                        .font(.system(size: 18))
                                        .padding(.trailing, 18)
                                }
                            }
                        }
                        
                        Spacer()
                        
                    }
                    .padding(.leading, 20)
                    .padding(.trailing, 20)
                }
                
            }
            
            
        }
        .edgesIgnoringSafeArea(.all)
    }
}

#Preview {
    MateAllNight()
}
