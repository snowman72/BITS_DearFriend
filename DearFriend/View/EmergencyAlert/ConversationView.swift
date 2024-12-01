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
                Spacer()
                
                Text("Emergency\n Alert")
                    .font(.system(size: 45))
                    .foregroundColor(Color.pink)
                    .fontWeight(.heavy)
                    .padding(.bottom, 50)
                    .multilineTextAlignment(.center)
                
                
                VStack {
                    HStack {
                        Image(systemName: "phone.fill")
                            .resizable()
                            .foregroundColor(Color.blue)
                            .frame(width: 30, height: 30)
                            .scaledToFit()
                            .padding(.trailing, 10)
                        
                        TextField("Enter phone number", text: $numberToMessage)
                            .font(.title)
                            .foregroundColor(.black)
                            .padding(10)
                            .background(
                                RoundedRectangle(cornerRadius: 5.0)
                                    .stroke(lineWidth: 0.7)
                                    .foregroundColor(Color.gray)
                            )
                        
                    }
                    .padding(.bottom, 20)
                    
                    HStack {
                        Image(systemName: "ellipsis.message.fill")
                            .resizable()
                            .foregroundColor(Color.blue)
                            .frame(width: 30, height: 30)
                            .scaledToFit()
                            .padding(.trailing, 10)
                        
                        TextField("Enter your message",text: $message)
                            .font(.title)
                            .foregroundColor(.black)
                            .padding(10)
                            .background(
                                RoundedRectangle(cornerRadius: 5.0)
                                    .stroke(lineWidth: 0.7)
                                    .foregroundColor(Color.gray)
                            )
                        
                        
                        
                    }
                    .padding(.bottom, 20)
                    
                    Button(action: {
                        sendMessage()
                    }, label: {
                        Text("Send Message")
                            .font(.title)
                            .fontWeight(.bold)
                            .foregroundStyle(Color.white)
                            .frame(width: 340, height: 65)
                            .background(Color.pink)
                            .cornerRadius(20)
                            .padding(.top, 20)
                    })
                }
                .padding(.vertical, 50)
                .padding(.horizontal, 30)
                .background {
                    Rectangle()
                        .foregroundColor(.white)
                        .cornerRadius(30)
                        .shadow(radius: 4)
                }

                
                Spacer()
                Spacer()
            }
            .padding(.vertical)
            .padding(.horizontal, 10)
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
