//
//  KaioApp.swift
//  Kaio
//
//  Created by Manraj Singh on 30/06/23.
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

@main
struct KaioApp: App {
    @StateObject var launchScreenState = LaunchScreenStateManager()
    @AppStorage("isDarkMode") private var isDarkMode = false
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
    
    var body: some Scene {
        WindowGroup {
            ZStack{
                //LoginView()
                // ExerciseList()
                // HomeView()
                
               // MainView()
                Welcome()
                    .preferredColorScheme(isDarkMode ? .dark : .light)
                if launchScreenState.state != .finished{
                    LaunchScreenView()
                }
            }.environmentObject(launchScreenState)
        }
    }
}
