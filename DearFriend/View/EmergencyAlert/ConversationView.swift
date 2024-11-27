//
//  ConversationView.swift
//  DearFriend
//
//  Created by Vũ Minh Hà on 12/9/24.
//

import SwiftUI

struct ConversationView: View {
    @EnvironmentObject var locationManager: LocationManager
    @State var numberToMessage = ""
    @State var message = ""

    var body: some View {
        ZStack {
            Image("background")
                .resizable()
                .aspectRatio(contentMode: .fill)
                .ignoresSafeArea()
            
            VStack {
                TextField("Enter phone number", text: $numberToMessage)
                    .padding(.bottom, 20)
                    .font(.title2)
                    .foregroundColor(.black)
                
                TextField("Enter your message",text: $message)
                    .font(.title2)
                    .foregroundColor(.black)
                    .padding(.bottom, 30)

                Button(action: {
                    sendMessage()
                }, label: {
                    Text("Send Message")
                        .font(.title)
                        .foregroundStyle(Color.blue)
                })
            }
            .padding(.vertical, 30)
            .padding(.horizontal, 20)
            .background {
                Rectangle()
                    .foregroundColor(.white)
                    .cornerRadius(30)
                    .shadow(radius: 4)
            }
            .padding()
        }
    }

    func sendMessage() {
        let sms: String = "sms:+84\(numberToMessage)&body=\(message). I'm at [\(locationManager.location?.coordinate.latitude ?? 0.0),\(locationManager.location?.coordinate.longitude ?? 0.0)]"
        let strURL: String = sms.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!
        UIApplication.shared.open(URL.init(string: strURL)!, options: [:], completionHandler: nil)
    }
}

#Preview {
    ConversationView()
        .environmentObject(LocationManager())
}
