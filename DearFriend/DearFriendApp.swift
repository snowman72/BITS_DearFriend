//
//  DearFriendApp.swift
//  DearFriend
//
//  Created by Vũ Minh Hà on 20/8/24.
//

import SwiftUI
import FirebaseCore
import Firebase
import StreamVideo
import StreamVideoSwiftUI

class AppDelegate: NSObject, UIApplicationDelegate {
    func application(_ application: UIApplication,
                     didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .sound, .badge]) { granted, _ in
            guard granted else { return }
            DispatchQueue.main.async {
                UIApplication.shared.registerForRemoteNotifications()
            }
        }
        return true
    }
    
//    func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
//        let tokenParts = deviceToken.map { data in String(format: "%02.2hhx", data) }
//        let token = tokenParts.joined()
//        print("Device Token: \(token)")
//        // Send this token to your server
//    }
    
//    func application(_ application: UIApplication, didReceiveRemoteNotification userInfo: [AnyHashable : Any], fetchCompletionHandler completionHandler: @escaping (UIBackgroundFetchResult) -> Void) {
//        if let aps = userInfo["aps"] as? [String: AnyObject] {
//            if let alert = aps["alert"] as? String {
//                if alert == "Incoming call" {
//                    handleIncomingCall(userInfo: userInfo)
//                }
//            }
//        }
//        completionHandler(.newData)
//    }

//    func handleIncomingCall(userInfo: [AnyHashable : Any]) {
//        let content = UNMutableNotificationContent()
//        content.title = "Incoming Call"
//        content.body = "You receive a call from a visually-impaired"
//        content.sound = UNNotificationSound(named: UNNotificationSoundName("ringtone.mp3"))
//        
//        let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: nil)
//        UNUserNotificationCenter.current().add(request)
//    }
}

@main
struct DearFriendApp: App {
    // register app delegate for Firebase setup
      @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
    
    @StateObject var locationManager = LocationManager()
    @StateObject var authViewModel = AuthViewModel()

    init(){
        FirebaseApp.configure()
    }
    

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(authViewModel)
                .environmentObject(locationManager)
        }
    }
}
