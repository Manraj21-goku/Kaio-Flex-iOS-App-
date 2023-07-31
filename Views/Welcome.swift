//
//  Welcome.swift
//  Kaio
//
//  Created by Manraj Singh on 21/07/23.
//

import SwiftUI

struct Welcome: View {
    @EnvironmentObject private var launchScreenState: LaunchScreenStateManager
    @State private var userIsLoggedIn = false
    @State private var userHasSignedUp = false
    var body: some View {
        NavigationView{
            if userIsLoggedIn{
               MainView()
            }
            else if userHasSignedUp{
                MainView()
            }
            else{
                LoginView(userIsLoggedIn: $userIsLoggedIn,userHasSignedUp: $userHasSignedUp)
                    .environmentObject(LaunchScreenStateManager())
            }
        }
        .task {
            try? await getDataFromApi()
            if #available(iOS 16.0, *) {
                try? await Task.sleep(for: Duration.seconds(1))
            } else {
                // Fallback on earlier versions
            }
            self.launchScreenState.dismiss()
        }
    }
    fileprivate func getDataFromApi() async throws {
        let googleURL = URL(string: "https://www.google.com")!
        let (_,response) = try await URLSession.shared.data(from: googleURL)
        print(response as? HTTPURLResponse as Any)
    }
}

struct link_Previews: PreviewProvider {
    static var previews: some View {
        Welcome()
    }
}
