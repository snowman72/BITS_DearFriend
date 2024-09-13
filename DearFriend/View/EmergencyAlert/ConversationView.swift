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
        VStack {
            TextField("Enter phone number", text: $numberToMessage)
            .padding(.vertical)
            TextField("Enter your message",text: $message)

            Button(action: {
                sendMessage()
            }, label: {
                Text("Send Message")
                    .font(.title)
                    .foregroundStyle(Color.blue)
            })
        }
        .padding()
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
