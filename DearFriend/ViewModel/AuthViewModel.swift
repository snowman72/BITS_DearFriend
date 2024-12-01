//
//  AuthViewModel.swift
//  DearFriend
//
//  Created by Tony Nguyen on 2024-09-10.
//

import Foundation
import Firebase
import FirebaseAuth
import FirebaseFirestore

protocol AuthenticationFormProtocol{
    var formIsValid: Bool {get}
}

@MainActor
class AuthViewModel: ObservableObject{
    @Published var userSession: FirebaseAuth.User?
    @Published var currentUser: Volunteer?

    init(){
        self.userSession = Auth.auth().currentUser

//        Task{
//            await fetchUser()
//        }
    }

    func signIn(withEmail email: String, password: String) async throws {
        do{
            let result = try await Auth.auth().signIn(withEmail: email, password: password)
            self.userSession = result.user
            let user = try await fetchUser()
            
            // Update the currentUser property
            await MainActor.run {
                self.currentUser = user
            }
            
        } catch{
            print("Login In error (DEBUG): \(error.localizedDescription)")
            throw NSError(domain: "Authentication", code: 401, userInfo: [NSLocalizedDescriptionKey: "Invalid credentials"])
        }
    }


    func createUser(withEmail email:String, password: String, name: String) async throws{
        do{
            let result = try await Auth.auth().createUser(withEmail: email, password: password)
            self.userSession = result.user
            let user = Volunteer(id: result.user.uid, name: name, email: email)
            let encodedUser = try Firestore.Encoder().encode(user)
            try await Firestore.firestore().collection("users").document(user.id).setData(encodedUser)
//            await fetchUser()
            currentUser = user
        } catch{
            print("Error in creating a new user: \(error.localizedDescription)")
        }
    }
    func signOut(){
        do{
            try Auth.auth().signOut()
            self.userSession = nil
            self.currentUser = nil

        } catch{
            print("Sign out error (DEBUG): \(error.localizedDescription)")
        }
    }

    func fetchUser() async throws -> Volunteer {
        guard let uid = Auth.auth().currentUser?.uid else{
            throw NSError(domain: "Authentication", code: 401, userInfo: [NSLocalizedDescriptionKey: "No authenticated user"])
        }

        let snapshot = try? await Firestore.firestore().collection("users").document(uid).getDocument()
        guard let currentUser = try? snapshot?.data(as: Volunteer.self) else {
            throw NSError(domain: "Firestore", code: 404, userInfo: [NSLocalizedDescriptionKey: "Failed to decode user data"])
        }
        
        return currentUser
    }
}
