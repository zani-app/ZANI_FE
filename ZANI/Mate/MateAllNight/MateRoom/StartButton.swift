//
//  StartButton.swift
//  ZANI
//
//  Created by 강석호 on 3/22/24.
//

import SwiftUI

struct StartButton: View {
    var body: some View {
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
    }
}

#Preview {
    StartButton()
}
