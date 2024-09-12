//
//  LoginView.swift
//  DearFriend
//
//  Created by Tony Nguyen on 2024-08-12.
//

import SwiftUI

struct LoginView:View {
    @EnvironmentObject var viewModel: AuthViewModel
    @EnvironmentObject var roleManager: RoleManager
    @State private var email = ""
    @State private var password = ""
   
    var body: some View{
        NavigationStack{
            VStack{
                // logo
                Image("logo")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 120,height: 120)
                    .padding(.vertical,32)
                
                // form fields
                VStack(spacing:24){
                    InputView(text: $email,
                              title: "Email",
                              placeholder: "name@example.com")
                    .autocapitalization(.none)
                    InputView(text: $password,
                              title: "Password",
                              placeholder: "Enter your pasword",
                              isSecureField: true)
                }
                .padding(.horizontal)
                .padding(.top,12)
                
                // sign in button
                Button{
                    Task{
                        try await viewModel.signIn(withEmail: email, password: password)
                    }
                } label: {
                    HStack{
                        Text("SIGN IN")
                            .fontWeight(.semibold)
                        Image(systemName: "arrow.right")
                    }
                    .foregroundColor(.white)
                    .frame(width: UIScreen.main.bounds.width - 32, height:48)
                }
                .background(Color(.systemBlue))
                .disabled(!formIsValid)
                .opacity(formIsValid ? 1.0 : 0.5)
                .cornerRadius(10)
                
                Spacer()
                // sign up button
                NavigationLink{
                    Registration()
                        .navigationBarBackButtonHidden(true)
                        .environmentObject(roleManager)
                    
                } label: {
                    HStack{
                        Text("Don't have an account")
                        Text("Sign up")
                            .fontWeight(.bold)
                    }
                    .font(.system(size: 14))
                }
            }
        }
    }
}

extension LoginView: AuthenticationFormProtocol{
    var formIsValid: Bool{
        return !email.isEmpty
        && email.contains("@")
        && !password.isEmpty
        && password.count > 5
    }
}

struct LoginView_Previews: PreviewProvider{
    static var previews: some View{
        LoginView()
    }
}
