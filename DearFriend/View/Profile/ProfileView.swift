//
//  Profile.swift
//  DearFriend
//
//  Created by Vũ Minh Hà on 17/9/24.
//

import SwiftUI

struct ProfileView: View {
//    var profile: Profile
    @EnvironmentObject var authViewModel: AuthViewModel
    @Binding var isShowProfileView: Bool

    var body: some View {
        NavigationStack {
            VStack(alignment: .center) {
                
                LinearGradient(colors: [Color.blue, Color.pink.opacity(0.5)], startPoint: .leading, endPoint: .trailing)
                    .frame(width: UIScreen.main.bounds.width, height: 200)
                    
                    ProfileIcon()
                    .frame(width: 150, height: 150)
                        .offset(y: -80)
                        
                
                ProfileDetails() // personal info
                    .offset(y: -120)
                
                Spacer()
                
            }.padding()
            .background(
                Color(red: 247/255, green: 245/255, blue: 255/255)
            )
            .navigationBarTitle("Profile", displayMode: .inline)
            .toolbar {
                // back to home button
                ToolbarItem(placement: .navigationBarLeading) {
                    Button("Home") {
                        isShowProfileView = false
                    }
                    .controlSize(.regular)
                    .buttonStyle(.bordered)
                    .padding(.horizontal, 10)
                    .padding(.vertical, 5)
                    .font(.title3.bold())
                    .background(Color(red: 0, green: 0, blue: 1))
                    .foregroundColor(.white)
                    .cornerRadius(10)
                }
            }
        }
        .navigationBarBackButtonHidden(true)
    }
}

#Preview {
    ProfileView(isShowProfileView: .constant(true))
        .environmentObject(AuthViewModel())
}
