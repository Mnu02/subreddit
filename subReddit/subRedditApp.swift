//
//  subRedditApp.swift
//  subReddit
//
//  Created by Mnumzana Franklin Moyo on 12/27/24.
//

import SwiftUI
import FirebaseCore


class AppDelegate: NSObject, UIApplicationDelegate {
  func application(_ application: UIApplication,
                   didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
    FirebaseApp.configure()

    return true
  }
}

class UserSession: ObservableObject {
    @Published var userId: String? = nil
}



@main
struct subRedditApp: App {
  @StateObject var userSession = UserSession()
  // register app delegate for Firebase setup
  @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate


  var body: some Scene {
    WindowGroup {
      NavigationView {
        ContentView()
              .environmentObject(userSession)
      }
    }
  }
}
