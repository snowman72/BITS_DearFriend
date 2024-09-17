//
//  ProfileIcon.swift
//  DearFriend
//
//  Created by Vũ Minh Hà on 17/9/24.
//

import SwiftUI

struct ProfileIcon: View {
    var body: some View {
        Circle()
            .frame(width: UIScreen.main.bounds.width)
            .foregroundColor(.red)
            .overlay(
                Image("profile")
                    .resizable()
                    .padding()
                    .aspectRatio(contentMode: .fit)
                    .shadow(color: .white, radius: 1)
            )
    }
}

#Preview {
    ProfileIcon()
}
