//
//  Login_VolunteerHome.swift
//  DearFriend
//
//  Created by Vũ Minh Hà on 16/9/24.
//

import SwiftUI

struct Login_VolunteerHome: View {
    @EnvironmentObject var authViewModel: AuthViewModel
    
    var body: some View {
        ZStack {
            if (authViewModel.userSession != nil) {
                VolunteerHome()
            } else {
                LoginView()
            }
        }
    }
}

#Preview {
    Login_VolunteerHome()
}
