//
//  DearFriendApp.swift
//  DearFriend
//
//  Created by Vũ Minh Hà on 20/8/24.
//

import SwiftUI
import FirebaseCore
import Firebase

class AppDelegate: NSObject, UIApplicationDelegate {
  func application(_ application: UIApplication,
                   didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
    return true
  }
}

@main
struct DearFriendApp: App {
    // register app delegate for Firebase setup
      @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
    
    @StateObject var locationManager = LocationManager()
    @StateObject var viewModel = AuthViewModel()

    init(){
        FirebaseApp.configure()
    }

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(viewModel)
                .environmentObject(locationManager)
        }
    }
}
