//
//  StartView.swift
//  DearFriend
//
//  Created by Tony Nguyen on 2024-08-26.
//

import SwiftUI

struct StartView: View {
    @EnvironmentObject var authViewModel: AuthViewModel
    @Binding var isShowStartView: Bool
    
    var body: some View {
        NavigationView {
            ZStack {
                Image("background")
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .ignoresSafeArea()
                
                VStack(spacing: 20) {
                    Image("logo")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 120,height: 120)
                        .padding(.vertical,20)
                    
                    Text("DearFriend,")
                        .fontWeight(.bold)
                        .font(.system(size: 45))
                        .frame(maxWidth: .infinity)
                        .frame(height: 60)
                        .padding()
                        .offset(y: -50)
                        .foregroundColor(.blue)
                    Text("let's \nsee the world together!")
                        .multilineTextAlignment(.center)
                        .fontWeight(.bold)
                        .font(.system(size: 25))
                        .padding(.bottom, 50)
                        .offset(y: -70)
                        .foregroundColor(.blue)
                    
//                    NavigationLink(destination: VIMainSelectionView()) {
//                        Text("Visually Imparied")
//                            .fontWeight(.semibold)
//                            .font(.system(size: 20))
//                            .frame(maxWidth: .infinity)
//                            .frame(height: 50)
//                            .padding()
//                            .background(Color.red)
//                            .foregroundColor(.white)
//                            .cornerRadius(10)
//                            .offset(y:-20)
//                    }
                    
                    Button(action: {
                        isShowStartView = false
                    }, label: {
                        Text("Visually Imparied")
                            .fontWeight(.semibold)
                            .font(.system(size: 20))
                            .frame(maxWidth: .infinity)
                            .frame(height: 50)
                            .padding()
                            .background(Color.red)
                            .foregroundColor(.white)
                            .cornerRadius(10)
                            .offset(y:-20)
                    })
                    
                    NavigationLink(destination: LoginView()
                    ) {
                        Text("Volunteer")
                            .fontWeight(.semibold)
                            .font(.system(size: 20))
                            .frame(maxWidth: .infinity)
                            .frame(height: 50)
                            .padding()
                            .background(Color.green)
                            .foregroundColor(.white)
                            .cornerRadius(10)
                            .offset(y:-20)
                    }
                }
                .padding()
            }
        }
    }
}

#Preview {
    StartView(isShowStartView: .constant(true))
}
