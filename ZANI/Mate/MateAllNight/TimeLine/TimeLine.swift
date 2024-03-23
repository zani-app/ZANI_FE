//
//  TimeLine.swift
//  ZANI
//
//  Created by 강석호 on 2024/03/19.
//

import SwiftUI

struct TimeLine: View {
    @EnvironmentObject private var mateMainPageManager: MateMainPageManager
    
    var body: some View {
        
        ScrollView(showsIndicators: false) {
            
            navigationBar()
            VStack(alignment: .leading, spacing: 0) {
                
                VStack(spacing: 1) {
                    ForEach(0 ... 2, id: \.self) { listing in
                        TimeLineSub()
                    }
                }
                .padding(.leading, 20)
                .padding(.top, 50)
                .background(Color.zaniMain1)
            }
            
        }
        .background(Color.zaniMain1)
        .navigationBarBackButtonHidden()
    }
    
}

extension TimeLine {
    
    @ViewBuilder
    private func navigationBar() -> some View {
        ZaniNavigationBar(title: "타임라인", leftAction: { mateMainPageManager.pop() })
    }
}

#Preview {
    TimeLine()
}
