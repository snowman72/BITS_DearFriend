//
//  VolunteerHome.swift
//  DearFriend
//
//  Created by Vũ Minh Hà on 14/9/24.
//

import SwiftUI

struct VolunteerHome: View {
    @EnvironmentObject var authViewModel: AuthViewModel
    @State var signOutSuccess = false
    
    var body: some View {
        ZStack {
            if (signOutSuccess == true) {
                StartView()
            } else {
                VStack {
                    Text("Hello \(authViewModel.currentUser?.name ?? "there"). This is Home page for Volunteers!")
                    Button(action: {
                        authViewModel.signOut()
                        signOutSuccess = true
                    }) {
                        Text("Sign Out")
                            .foregroundColor(.white)
                            .frame(width: UIScreen.main.bounds.width - 32, height: 48)
                            .background(Color.red)
                            .cornerRadius(10)
                    }
                    .padding()
                }
            }
        }
    }
}
