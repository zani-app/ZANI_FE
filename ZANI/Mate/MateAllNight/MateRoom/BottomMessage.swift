//
//  BottomMessage.swift
//  ZANI
//
//  Created by 강석호 on 3/22/24.
//

import SwiftUI

struct BottomMessage: View {
    var body: some View {
        HStack {
            Spacer()
            ZStack {
                Rectangle()
                    .fill(Color.zaniMain4)
                    .frame(width: 160, height: 35)
                .clipShape(RoundedCorner(radius: 20, corners: [.topLeft, .bottomLeft, .bottomRight]))
                Text("자니...? 진짜 자니?")
                    .foregroundStyle(.white)
            }
            Image("moon4")
                .padding(.trailing, 20)
        }
        
    }
}

struct RoundedCorner: Shape {
    var radius: CGFloat = .infinity
    var corners: UIRectCorner = .allCorners

    func path(in rect: CGRect) -> Path {
        let path = UIBezierPath(
            roundedRect: rect,
            byRoundingCorners: corners,
            cornerRadii: CGSize(width: radius, height: radius)
        )
        return Path(path.cgPath)
    }
}

#Preview {
    BottomMessage()
}
