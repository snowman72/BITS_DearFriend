//
//  LoginView.swift
//  DearFriend
//
//  Created by Tony Nguyen on 2024-08-12.
//

import SwiftUI

struct LoginView:View {
    @EnvironmentObject var viewModel: AuthViewModel
    @State private var email = ""
    @State private var password = ""
    @State private var showlogInFailMessage = false
   
    var body: some View{
        NavigationView{
            VStack{
                Text("Login")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                
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
                    .padding(.bottom)
                    
                    InputView(text: $password,
                              title: "Password",
                              placeholder: "Enter your pasword",
                              isSecureField: true)
                }
                .padding(.horizontal)
                .padding(.top,12)
                
                HStack{
                    Text("Don't have an account?")
                        .foregroundStyle(Color.blue)
                    // sign up button
                    NavigationLink{
                        Registration()
                            .navigationBarBackButtonHidden(true)
                    } label: {
                        Text("Sign up")
                            .underline()
                            .fontWeight(.bold)
                    }
                }
                .font(.system(size: 14))
                .padding(.top, 20)
                .padding(.leading, UIScreen.main.bounds.width/3)
                
                
                // sign in button
                Button {
                    Task {
                        do {
                            try await viewModel.signIn(withEmail: email, password: password)
                        } catch {
                            showlogInFailMessage = true
                            print("Sign in failed: \(error.localizedDescription)")
                        }
                    }
                } label: {
                    HStack{
                        Text("SIGN IN")
                            .fontWeight(.semibold)
                            .font(.title2)
                        Image(systemName: "arrow.right")
                    }
                    .foregroundColor(.white)
                    .frame(width: UIScreen.main.bounds.width - 65, height:70)
                    .background(Color(.systemBlue))
                    .opacity(formIsValid ? 1.0 : 0.5)
                    .cornerRadius(10)
                    .padding(.top, 40)
                }
                .disabled(!formIsValid)
                
                
                
                Text(showlogInFailMessage == true ? "Incorrect email or password" : "")
                    .font(.callout)
                    .foregroundStyle(Color.red)
                
                Spacer()
                
            }
            .padding()
            .background(
                Image("background")
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .ignoresSafeArea()
            )
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

#Preview {
    LoginView()
}
