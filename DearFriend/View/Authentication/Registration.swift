//
//  Registration.swift
//  DearFriend
//
//  Created by Tony Nguyen on 2024-08-12.
//

import SwiftUI

struct Registration: View {
    @State private var email = ""
    @State private var fullname = ""
    @State private var password = ""
    @State private var confirmPassword = ""
    @Environment(\.dismiss) var dismiss
    @EnvironmentObject var viewModel: AuthViewModel
//    @EnvironmentObject var roleManager: RoleManager
    
    var body: some View {
        VStack{
            // logo
            Image("logo")
                .resizable()
                .scaledToFit()
                .frame(width: 120,height: 120)
                .padding(.vertical,32)
        }
        // form fields
        VStack(spacing:24){
            InputView(text: $email,
                      title: "Email",
                      placeholder: "name@example.com")
            .autocapitalization(.none)
            InputView(text: $fullname,
                      title: "Full Name",
                      placeholder: "Enter your name")
            InputView(text: $password,
                      title: "Password",
                      placeholder: "Enter your pasword",
                      isSecureField: true)
            ZStack(alignment: .trailing){
                InputView(text: $confirmPassword,
                          title: "Confirm Password",
                          placeholder: "Enter your pasword again",
                          isSecureField: true)
                if !password.isEmpty && !confirmPassword.isEmpty{
                    if password == confirmPassword {
                        Image(systemName: "checkmark.circle.fill")
                            .imageScale(.large)
                            .fontWeight(.bold)
                            .foregroundColor(Color(.systemGreen))
                    } else{
                        Image(systemName: "xmark.circle.fill")
                            .imageScale(.large)
                            .fontWeight(.bold)
                            .foregroundColor(Color(.systemRed))
                    }

                }
            }
        }
        .padding(.horizontal)
        .padding(.top,12)
        
        Button{
            Task {
                try await viewModel.createUser(withEmail:email, password: password, fullname: fullname)
            }
        } label: {
            HStack{
                Text("SIGN UP")
                    .fontWeight(.semibold)
                Image(systemName: "arrow.right")
            }
            .foregroundColor(.white)
            .frame(width: UIScreen.main.bounds.width - 32, height:48)
            .disabled(!formIsValid)
            .opacity(formIsValid ? 1.0 : 0.5)
        }
        .background(Color(.systemBlue))
        .cornerRadius(10)
        .padding(.top,24)
        
        Spacer()
        
        Button{
            dismiss()
        }label: {
            HStack{
                Text("Already have account")
                Text("Sign in")
                    .fontWeight(.bold)
            }
            .font(.system(size: 14))
        }
    }
}

extension Registration: AuthenticationFormProtocol{
    var formIsValid: Bool{
        return !email.isEmpty
        && email.contains("@")
        && !password.isEmpty
        && password.count > 5
        && confirmPassword == password
        && !fullname.isEmpty
    }
}

#Preview {
    Registration()
//        .environmentObject(RoleManager())
}
