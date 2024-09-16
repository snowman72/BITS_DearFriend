import Foundation
import SwiftUI

struct Profile {
    var fullname: String
    var phoneNumber: String
    var emailAddress: String
    var imageName: String
}

struct ProfileAvatar: View {
    // the profile avatar
    var imageName: String
    
    var body: some View {
        Image(imageName)
            .resizable()
            .aspectRatio(contentMode: .fill)
            .frame(width: 150, height: 150)
            .clipShape(Circle())
            .overlay(Circle().stroke(Color.white, lineWidth: 4))
            .shadow(radius: 10)
    }
}


struct Header: View {
    // avatar + cover
    var avatar: ProfileAvatar
    var body: some View {
        ZStack(alignment: .bottom) {
            LinearGradient(gradient: Gradient(colors: [Color.blue, Color.pink.opacity(0.5)]),
                                       startPoint: .leading,
                                       endPoint: .trailing)
                            .frame(height: 200)
                        avatar
                            .offset(y: 60)
        }
    }
}

struct ProfileField: Identifiable {
    let id = UUID()
    let icon: String
    let label: String
    var value: String
}

struct ProfileFieldView: View {
    // field icon, name and value (icon | fullname: capybara)
    var field: ProfileField
    var body: some View {
        HStack {
            Image(systemName: field.icon)
                .foregroundColor(Color(red: 0, green: 0, blue: 1))
                .font(.system(size: 30))
                .frame(width: 50, height: 50)
                .background(Color.blue.opacity(0.1))
                .clipShape(Circle())
            
            VStack(alignment: .leading, spacing: 4) {
                Text(field.label)
                    .font(.system(size: 21, weight: .semibold))
                Spacer().frame(height: 3)
                Text(field.value)
                    .font(.system(size: 18, weight: .medium))
            }.padding(.horizontal, 15)
            Spacer()
//            Image(systemName: "info.circle").foregroundColor(.gray)
        }
        .padding()
        .background(Color.white)
        .cornerRadius(10)
        .shadow(color: Color.gray.opacity(0.4), radius: 5, x: 0, y: 2)
        Spacer().frame(height: 20)
    }
}

struct ProfileDetails: View {
    // display fullname, phone and email of user
    var profile: Profile
    
    var profileFields: [ProfileField] {
        [
            ProfileField(icon: "person.fill", label: "Full Name", value: profile.fullname),
            ProfileField(icon: "phone.fill", label: "Phone", value: profile.phoneNumber),
            ProfileField(icon: "envelope.fill", label: "Email", value: profile.emailAddress)
        ]
    }
    
    var body: some View {
        VStack {
            ForEach(profileFields) { field in
                ProfileFieldView(field: field)
            }
        }
        .listStyle(PlainListStyle())
        .padding(.top, 80)
        .padding(10)
    }
}


struct ProfileView: View {
    @Binding var profile: Profile
    @State private var navigateToHome = false
    @State private var navigateToEdit = false
    var body: some View {
        NavigationStack {
            VStack(alignment: .leading, spacing: 0) {
                Header(avatar: ProfileAvatar(imageName: profile.imageName)) // the header: image + cover
                    .padding(.bottom, 10)
                ProfileDetails(profile: profile) // personal info
                Spacer()
            }.padding()
            .background(Color(red: 247/255, green: 245/255, blue: 255/255))
            .navigationBarTitle("Profile", displayMode: .inline)
            .toolbar {
                // back to home button
                ToolbarItem(placement: .navigationBarLeading) {
                    Button("Home") {
                        navigateToHome = true
                    }
                    .controlSize(.regular)
                    .buttonStyle(.bordered)
                    .padding(.horizontal, 10)
                    .padding(.vertical, 5)
                    .font(.title3.bold())
                    .background(Color(red: 0, green: 0, blue: 1))
                    .foregroundColor(.white)
                    .clipShape(RoundedCorner(radius: 10))
                }
                // edit button
                
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Edit") {
                        navigateToEdit = true
                    }
                    .controlSize(.regular)
                    .buttonStyle(.bordered)
                    .padding(.horizontal, 10)
                    .padding(.vertical, 5)
                    .font(.title3.bold())
                    .background(Color(red: 0, green: 0, blue: 1))
                    .foregroundColor(.white)
                    .clipShape(RoundedCorner(radius: 10))
                }
                // sign out button
                ToolbarItem(placement: .bottomBar) {
                    Button("Log Out") {
                    }
                    .frame(maxWidth: .infinity, alignment: .center)
                     .foregroundColor(.white)
                     .padding()
                     .background(Color(red: 0, green: 0, blue: 1))
                     .cornerRadius(10)
                     .buttonStyle(.bordered)
                     .font(.title3.bold())
                }
            }
            .navigationDestination(isPresented: $navigateToHome) {
                HomePage() // move to homepage
            }
            .navigationDestination(isPresented: $navigateToEdit) {
                EditProfile(profile: profile) // move to edit profile page
            }
        }.navigationBarBackButtonHidden(true)
    }
}
