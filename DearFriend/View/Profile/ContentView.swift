//
//  ContentView.swift
//  UserProfile
//
//  Created by Lam on 03/09/2024.
//

import SwiftUI

struct ProfileContentView: View {
    @State var defaultProfile = Profile(fullname: "Capybara Ng", phoneNumber: "0123 456789",
                                 emailAddress: "mrcapybara@gmail.com",
                                 imageName: "capybara")
    
    var body: some View {
        ProfileView(profile: $defaultProfile)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileContentView()
    }
}
