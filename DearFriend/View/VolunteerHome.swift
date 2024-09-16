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
//    @EnvironmentObject var callManager: CallManager
    @State var signOutSuccess = false
    @State private var showingIncomingCall = true
    
    var body: some View {
        ZStack {
            if (signOutSuccess == true) {
                StartView()
                
//            } else if (showingIncomingCall) {
//                VStack {
//                    Text("Incoming Call")
//                        .font(.largeTitle)
//                        .fontWeight(.bold)
//                        .padding(.top, 50)
//                    Spacer()
//                    HStack {
//                        // Accept call
//                        Button {
////                            callManager.handleIncomingCall(accept: true)
//                            showingIncomingCall = false
//                        } label: {
//                            Image(systemName: "phone.circle.fill")
//                                .resizable()
//                                .frame(width: /*@START_MENU_TOKEN@*/100/*@END_MENU_TOKEN@*/, height: 100)
//                                .foregroundStyle(Color.green)
//                        }
//
//                        Spacer()
//
//                        // Decline call
//                        Button {
////                            callManager.handleIncomingCall(accept: false)
//                            showingIncomingCall = false
//                        } label: {
//                            Image(systemName: "x.circle.fill")
//                                .resizable()
//                                .frame(width: /*@START_MENU_TOKEN@*/100/*@END_MENU_TOKEN@*/, height: 100)
//                                .foregroundStyle(Color.red)
//                        }
//                    }
//                    .padding(.horizontal, 40)
//                }
//                .padding()
//                .background(
//                    LinearGradient(colors: [Color.green, Color.blue, Color.white], startPoint: .top, endPoint: .bottom)
//                )

            } else {
                VStack {
                    Spacer()
                    
                    Text("Hello \(authViewModel.currentUser?.name ?? "there")! Looks like you have no call at the moment")
                    
//                    Spacer()
                    
                    Image("sleep")
                        .resizable()
                        .frame(width: 180, height: 180)
                    
                    Spacer()
                    
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
        .onReceive(NotificationCenter.default.publisher(for: Notification.Name("IncomingCall"))) { _ in
                    showingIncomingCall = true
                }
    }
}

#Preview {
    VolunteerHome()
        .environmentObject(AuthViewModel())
//        .environmentObject(CallManager())
}
