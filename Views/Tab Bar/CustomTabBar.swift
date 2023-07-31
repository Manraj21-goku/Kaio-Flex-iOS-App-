//
//  CustomTabBar.swift
//  Kaio
//
//  Created by Manraj Singh on 19/07/23.
//

import SwiftUI
enum Tabs: Int{
    case Home = 0
    case Exercises = 1
    case Workout = 2
    case Settings = 3
}
struct CustomTabBar: View {
    @Binding var selectedTab: Tabs
    var body: some View {
        HStack(alignment:.center){
            
            Button {
                //switch to
                selectedTab = .Home
               
            } label: {
                TabBarButton(buttonText: "Home", imageName: "house", isActive: selectedTab == .Home)

                
            }
            Button {
                // switch to exer
                selectedTab = .Exercises
             
            } label: {
                TabBarButton(buttonText: "Exercises", imageName: "dumbbell", isActive: selectedTab == .Exercises)
            }
            
            Button {
                // switch to exer
                selectedTab = .Workout
               
            } label: {
                TabBarButton(buttonText: "Workout", imageName: "plus.circle", isActive: selectedTab == .Workout)
            }
            
            Button {
                // switch to exer
                selectedTab = .Settings
              
            } label: {
                TabBarButton(buttonText: "Settings", imageName: "gear", isActive: selectedTab == .Settings)
            }
            
        }
        .frame(height: 82)
    }
}

struct CustomTabBar_Previews: PreviewProvider {
    static var previews: some View {
        CustomTabBar(selectedTab: .constant(.Home))
    }
}
