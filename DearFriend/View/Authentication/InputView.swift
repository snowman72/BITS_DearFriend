//
//  InputView.swift
//  DearFriend
//
//  Created by Tony Nguyen on 2024-08-12.
//

import SwiftUI

struct InputView: View{
    @Binding var text: String
    let title: String
    let placeholder: String
    var isSecureField = false
    
    var body: some View{
        VStack(alignment: .leading) {
            Text(title)
                .foregroundColor(Color(.darkGray))
                .fontWeight(.semibold)
                .font(.title3)
                .padding(.bottom)
            if isSecureField{
                SecureField(placeholder, text: $text)
                    .font(.title3)
                    .padding(.horizontal)
                    .background(
                        Rectangle()
                            .foregroundColor(Color.white)
                            .frame(height: 60)
                            .cornerRadius(10)
                            .background(
                                RoundedRectangle(cornerSize: CGSize(width: 10, height: 10))
                                    .stroke(Color.black, lineWidth: 0.5)
                            )
                        )
            } else{
                TextField(placeholder, text: $text)
                    .font(.title3)
                    .padding(.horizontal)
                    .background(
                        Rectangle()
                            .foregroundColor(Color.white)
                            .frame(height: 60)
                            .cornerRadius(10)
                            .background(
                                RoundedRectangle(cornerSize: CGSize(width: 10, height: 10))
                                    .stroke(Color.black, lineWidth: 0.5)
                            )
                        )
            }
            
//            Divider()
        }
    }
}

struct InputView_Previews: PreviewProvider{
    static var previews: some View{
        InputView(text: .constant(""), title: "Email Address", placeholder: "name@example.com")
    }
}
