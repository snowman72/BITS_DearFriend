//
//  InstructionView.swift
//  DearFriend
//
//  Created by Vũ Minh Hà on 1/12/24.
//

import SwiftUI

struct InstructionView: View {
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        ZStack {
            Image("background")
                .resizable()
                .aspectRatio(contentMode: .fill)
                .ignoresSafeArea()
            
            VStack {
                Text("How to Use")
                    .font(.largeTitle)
                    .fontWeight(.semibold)
                    .frame(width: UIScreen.main.bounds.width - 40, alignment: .center)
                    .padding(.bottom, 30)
                
                VStack(alignment: .leading, spacing: 30) {
                    
                    Text("Hello there! I'm your new friend. I have four main modes for you to use, you select the button with the name of the mode to use it. The instruction for each mode is below:")
                    
                    Text("See Object: ")
                        .fontWeight(.bold)
                    
                    + // concatenate
                    
                    Text("Hover the camera over an object and the app will speak out its name")
                    
                    Text("See Text: ")
                        .fontWeight(.bold)
                    
                    + // concatenate
                    
                    Text("Hover the camera over some text and the app will read it out for you")
                    
                    Text("Emergency Alert: ")
                        .fontWeight(.bold)
                    
                    + // concatenate
                    
                    Text("Enter your contact's phone number, type out your message and click Send Message. Then the app will redirect you to SMS. Upon selecting the Send button of SMS, your message, along with coordinate location is sent to that contact")
                    
                    Text("Call a Volunteer: ")
                        .fontWeight(.bold)
                    
                    + // concatenate
                    
                    Text("Put you into a 1-1 video call with an enthusiastic volunteer! Here you can ask them any questions that you have")
                    
//                    NavigationLink(value: <#T##Hashable?#>) { 
//                        
//                    }
                    Button(action: {
                        dismiss()
                    }, label: {
                        Text("I've understood")
                            .font(.title3)
                            .foregroundColor(Color.white)
                            .background(
                                RoundedRectangle(cornerRadius: 10)
                                    .foregroundColor(Color.blue)
                                    .frame(width: 200, height: 60)
                                    .padding()
                            )
                    })
                    .frame(width: UIScreen.main.bounds.width - 50, height: 50, alignment: .center)
                    .padding(.top, 20)
                }
            }
            .padding()
            .padding(.horizontal)
        }
    }
}

#Preview {
    InstructionView()
}
