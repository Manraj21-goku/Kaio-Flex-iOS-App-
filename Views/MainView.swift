//
//  MainView.swift
//  Kaio
//
//  Created by Manraj Singh on 19/07/23.
//

import SwiftUI

@available(iOS 16.0, *)
struct MainView: View {
    @EnvironmentObject private var launchScreenState: LaunchScreenStateManager
    var body: some View {
        
        TabView{
           HomeView()
                .tabItem {
                    Label("Home",systemImage: "house")
                }
           ExerciseList()
                .tabItem {
                    Label("Exercises",systemImage: "dumbbell")
                }
            Start_WorkoutVIEW()
                .tabItem {
                    Label("Workout",systemImage: "plus.circle")
                }
            SettingsView()
                .tabItem {
                    Label("Settings",systemImage: "gear")
                }
                
        }
        /*.task {
            try? await getDataFromApi()
            if #available(iOS 16.0, *) {
                try? await Task.sleep(for: Duration.seconds(1))
            } else {
                // Fallback on earlier versions
            }
            self.launchScreenState.dismiss()
        }*/
        
    }
   
}

@available(iOS 16.0, *)
struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
