import SwiftUI

struct EditProfileField: View {
    // field for edit
    let icon: String
    let label: String
    @Binding var value: String
    
    var body: some View {
        TextField(label, text: $value)
            .font(.system(size: 20, weight: .medium))
            .padding(.horizontal, 15)
            .padding(.vertical, 10)
    }
}

struct EditProfileAvatar: View {
    // field to edit avatar
    let imageName: String
    
    var body: some View {
        Button("Upload Image") {
            // load avatar and choose image
        }.frame(maxWidth: .infinity, alignment: .center)
         .foregroundColor(.white)
         .padding()
         .background(Color(red: 0, green: 0, blue: 1))
         .cornerRadius(10)
         .buttonStyle(.bordered)
         .font(.title3.bold())
    }
}

struct EditProfile: View {
    @State private var navigateToProfile = false
    @State var profile: Profile
    
    var body: some View {
        NavigationStack {
            ZStack {
                Form {
                    // edit avatar
                    Section(header: Text("Avatar").font(.body)) {
                        ProfileAvatar(imageName: profile.imageName)
                            .padding()
                            .frame(maxWidth: .infinity, alignment: .center)
                            .background(Color.pink.opacity(0.2))
                        EditProfileAvatar(imageName: profile.imageName)
                    }
                    // edit personal info
                    Section(header: Text("Personal Information").font(.body)) {
                        EditProfileField(icon: "person.fill", label: "Full Name", value: $profile.fullname)
                        EditProfileField(icon: "phone.fill", label: "Phone", value: $profile.phoneNumber)
                        EditProfileField(icon: "envelope.fill", label: "Email", value: $profile.emailAddress)
                    }
                }
                
            }.background(Color(red: 247/255, green: 245/255, blue: 255/255))
                .scrollContentBackground(.hidden)
                .padding(.vertical, 20)
                .navigationBarTitle("Edit Profile", displayMode: .inline)
                .toolbar {
                    ToolbarItem(placement: .navigationBarLeading) {
                        Button("Profile") {
                            navigateToProfile = true
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
                    
                    ToolbarItem(placement: .navigationBarTrailing) {
                        Button("Save") {
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
                }.navigationDestination(isPresented: $navigateToProfile) {
                    ProfileContentView()
                }
        }
        .navigationViewStyle(StackNavigationViewStyle())
        .navigationBarBackButtonHidden(true)
        
    }
}



