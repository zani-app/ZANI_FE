//
//  CountText.swift
//  ZANI
//
//  Created by 강석호 on 3/22/24.
//

import SwiftUI

struct CountText: View {
    var body: some View {
        HStack {
            Text("현재 @명의 메이트들이 밤샘 진행중입니다!")
                .foregroundColor(Color.zaniMain2)
                .fontWeight(.bold)
                .font(.system(size: 18))
            Spacer()
        }
        .background(Color.zaniMain1)
    }
}

#Preview {
    CountText()
}
