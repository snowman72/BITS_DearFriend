//
//  VolunteerHome.swift
//  DearFriend
//
//  Created by Vũ Minh Hà on 14/9/24.
//

import SwiftUI
import StreamVideo
import StreamVideoSwiftUI

struct VolunteerHome: View {
    @EnvironmentObject var authViewModel: AuthViewModel
    @State var signOutSuccess = false
//    @State private var showingIncomingCall = true
    @Binding var isShowProfileView: Bool
    
    var body: some View {
        ZStack {
            Image("background")
                .resizable()
                .aspectRatio(contentMode: .fill)
                .ignoresSafeArea(.all)
            
            if (signOutSuccess == true) {
                StartView(isShowStartView: .constant(true))
                

            } else {
                VStack {
                    Button {
                        isShowProfileView = true
                    } label: {
                        ProfileIcon()
                            .frame(width: 120, height: 120)
                    }
                    .offset(x: 130)
                    
                    Spacer()
                    
                    Text("Hello \(authViewModel.currentUser?.name ?? "there")! Looks like you have no call at the moment")
                        .font(.title2)
                    
                    
                    Image("sleep")
                        .resizable()
                        .frame(width: 180, height: 180)
                    
                    Spacer()
                    
                    Button(action: {
                        authViewModel.signOut()
                        signOutSuccess = true
                    }) {
                        Text("Sign Out")
                            .font(.title)
                            .foregroundColor(.white)
                            .frame(maxWidth: .infinity, minHeight: 70)
                            .background(Color.red)
                            .cornerRadius(10)
                    }
                    
                }
                .padding(.bottom, 80)
                .padding(.top, 50)
                .padding(.horizontal)
            }
        }
//        .onReceive(NotificationCenter.default.publisher(for: Notification.Name("IncomingCall"))) { _ in
//                    showingIncomingCall = true
//                }
    }
}

#Preview {
    VolunteerHome(isShowProfileView: .constant(false))
        .environmentObject(AuthViewModel())

}
