//
//  StartView.swift
//  DearFriend
//
//  Created by Tony Nguyen on 2024-08-26.
//

import SwiftUI

struct StartView: View {
    @StateObject var roleManager = RoleManager()  // Create a shared instance
    
    var body: some View {
        NavigationView {
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

                NavigationLink(destination: VIMainSelectionView()) {
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
                }

                NavigationLink(destination: LoginView().environmentObject(roleManager)) {
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
                    .simultaneousGesture(TapGesture().onEnded {
                        roleManager.ROLE = "Volunteer"
                    })

                NavigationLink(destination: LoginView().environmentObject(roleManager)) {
                        Text("Family Member")
                            .fontWeight(.semibold)
                            .font(.system(size: 20))
                            .frame(maxWidth: .infinity)
                            .frame(height: 50)
                            .padding()
                            .background(Color.blue)
                            .foregroundColor(.white)
                            .cornerRadius(10)
                            .offset(y:-20)
                    }
                    .simultaneousGesture(TapGesture().onEnded {
                        roleManager.ROLE = "FamilyMember"
                    })
            }
            .padding()
        
        }
    }
}

#Preview {
    StartView()
}
