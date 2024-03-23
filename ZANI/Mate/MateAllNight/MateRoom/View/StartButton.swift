//
//  StartButton.swift
//  ZANI
//
//  Created by 강석호 on 3/22/24.
//

import SwiftUI

struct StartButton: View {
    @State private var isClicked = false // State variable to track button click
    
    var body: some View {
        Button(action: {
            // Toggle the state when button is clicked
            self.isClicked.toggle()
        }) {
            Text("밤샘 시작하기")
                .frame(maxWidth: .infinity)
                .foregroundColor(.black)
                .padding()
                .background(isClicked ? Color.gray : Color.zaniMain2) // Change background color based on state
                .cornerRadius(20)
                .fontWeight(.bold)
        }
    }
}

#Preview {
    StartButton()
}
