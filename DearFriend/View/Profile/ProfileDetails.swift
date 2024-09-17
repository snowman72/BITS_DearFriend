//
//  ProfileDetails.swift
//  DearFriend
//
//  Created by Vũ Minh Hà on 17/9/24.
//

import SwiftUI

struct ProfileDetails: View {
//    var profile: Profile
    @EnvironmentObject var authViewModel: AuthViewModel
        
    var profileFields: [ProfileField] {
        [
            ProfileField(icon: "person.fill", label: "Full Name", value: authViewModel.currentUser?.name ?? ""),
            ProfileField(icon: "envelope.fill", label: "Email", value: authViewModel.currentUser?.email ?? "")
        ]
    }
    
    var body: some View {
        VStack {
            ForEach(profileFields) { field in
                ProfileFieldView(field: field)
            }
        }
        .listStyle(PlainListStyle())
        .padding(.top, 80)
        .padding(10)
    }
}

#Preview {
    ProfileDetails()
}
