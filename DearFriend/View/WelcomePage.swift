//
//  WelcomePage.swift
//  UserProfile
//
//  Created by Lam on 10/09/2024.
//

import SwiftUI

struct WelcomeField: Identifiable {
    let id = UUID()
    var icon: String
    var text: String
}

struct WelcomeFieldView: View {
    var field: WelcomeField
    
    
    var body: some View {
        HStack {
            Image(systemName: field.icon)
                .font(.system(size: 24))
                .frame(width: 40, height: 40)
                .padding(.horizontal, 15)
            Text(field.text).font(.system(size: 20)).foregroundColor(.black)
                .fontWeight(.semibold)
        }.padding(.vertical, 5)
    }
}

struct WelcomePage: View {
    let welcomeFields = [
        WelcomeField(icon: "textformat", text: "Text Recognition"),
        WelcomeField(icon: "eye.fill", text: "Object Recognition"), // replace the apple icon
        WelcomeField(icon: "video", text: "Call a Volunteer"),
        WelcomeField(icon: "exclamationmark.bubble", text: "Alert Emergency Contact")
    
    ]
    var body: some View {
            ZStack {
    //             change to angular gradient
                Image("Screen").resizable().edgesIgnoringSafeArea(.top)
                
                VStack(spacing: 20) {
                    Text("Welcome,").font(.system(size: 50))
                        .fontWeight(.bold)
                        .foregroundColor(Color(red: 0, green:0, blue: 1))
                        .padding(.bottom, 10)
                    
                    Text("With DearFriend, you can get visual support and more: ")
                        .font(.system(size: 20))
                        .fontWeight(.medium)
                        .multilineTextAlignment(.center)
                        .foregroundColor(Color(red: 0, green:0, blue: 1))
                        .padding(.horizontal)
                    
                    
                    VStack(alignment: .leading, spacing: 15) {
                        ForEach(welcomeFields) {
                            field in WelcomeFieldView(field: field)
                        }
                    }
                    
                    Button("Get Started") {
                    }
                    .frame(maxWidth: .infinity, alignment: .center)
                     .foregroundColor(.white)
                     .padding()
                     .background(Color(red: 0, green: 0, blue: 1))
                     .cornerRadius(10)
                     .buttonStyle(.bordered)
                     .font(.title3.bold())
                }.padding(.horizontal, 20)
            }
        }
}

struct WelcomePage_Previews: PreviewProvider {
    static var previews: some View {
        WelcomePage()
    }
}
