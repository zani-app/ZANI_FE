//
//  TimeLine.swift
//  ZANI
//
//  Created by 강석호 on 2024/03/19.
//

import SwiftUI

struct TimeLine: View {
    
    var body: some View {
        
        NavigationStack {
            ScrollView(showsIndicators: false) {
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
            
        }
        .navigationBarTitle("타임라인", displayMode: .inline)
    }
    
}

#Preview {
    TimeLine()
}
