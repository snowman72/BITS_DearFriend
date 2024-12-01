//
//  Registration.swift
//  DearFriend
//
//  Created by Tony Nguyen on 2024-08-12.
//

import SwiftUI

struct Registration: View {
    @State private var email = ""
    @State private var name = ""
    @State private var password = ""
    @State private var confirmPassword = ""
    @Environment(\.dismiss) var dismiss
    @EnvironmentObject var viewModel: AuthViewModel
    @State private var showRegisterFailMessage = false
    @State private var failMessage = ""
    
    var body: some View {
        VStack {
            Spacer()
            
            Text("Register")
                .font(.largeTitle)
                .fontWeight(.bold)
            
            Image("logo")
                .resizable()
                .scaledToFit()
                .frame(width: 80,height: 80)
            
            // form fields
            VStack(spacing:24){
                
                InputView(text: $email,
                          title: "Email",
                          placeholder: "name@example.com")
                .autocapitalization(.none)
                .padding(.bottom)
                InputView(text: $name,
                          title: "Full Name",
                          placeholder: "Enter your name")
                .padding(.bottom)
                InputView(text: $password,
                          title: "Password",
                          placeholder: "Enter your pasword",
                          isSecureField: true)
                .padding(.bottom)
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
                                .padding(.top, 50)
                                .padding(.trailing, 10)
                        } else{
                            Image(systemName: "xmark.circle.fill")
                                .imageScale(.large)
                                .fontWeight(.bold)
                                .foregroundColor(Color(.systemRed))
                                .padding(.top, 50)
                                .padding(.trailing, 10)
                        }
                        
                    }
                }
            }
            .padding(.horizontal, 33)
            .padding(.top,12)
            
            Button{
                Task {
                    do {
                        try await viewModel.createUser(withEmail:email, password: password, name: name)
                    } catch {
                        showRegisterFailMessage = true
                        failMessage = error.localizedDescription
                    }
                }
            } label: {
                HStack{
                    Text("SIGN UP")
                        .fontWeight(.semibold)
                        .font(.title2)
                    Image(systemName: "arrow.right")
                }
                .foregroundColor(.white)
                .frame(width: UIScreen.main.bounds.width - 65, height:70)
                .background(Color(.systemBlue))
                .opacity(formIsValid ? 1.0 : 0.5)
                .cornerRadius(10)
                .padding(.top,40)
            }
            .disabled(!formIsValid)
            
            Text(showRegisterFailMessage == true ? failMessage : "")
                .font(.callout)
                .foregroundStyle(Color.red)
            
            Spacer()
            Spacer()
            
            HStack{
                Text("Already have account?")
                    .font(.callout)
                Button{
                    dismiss()
                }label: {
                    Text("Sign in")
                        .fontWeight(.bold)
                        .underline()
                        .font(.system(size: 14))
                }
            }
            .foregroundColor(Color.blue)
            .padding(.horizontal)
        }
        .background(
            Image("background")
                .resizable()
                .aspectRatio(contentMode: .fill)
                .ignoresSafeArea()
        )
    }
}

extension Registration: AuthenticationFormProtocol{
    var formIsValid: Bool{
        return !email.isEmpty
        && email.contains("@")
        && !password.isEmpty
        && password.count > 5
        && confirmPassword == password
        && !name.isEmpty
    }
}

#Preview {
    Registration()
}
