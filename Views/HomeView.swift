//
//  HomeView.swift
//  Kaio
//
//  Created by Manraj Singh on 17/07/23.
//
import Foundation
import SwiftUI
import Firebase
import FirebaseAuth
import FirebaseStorage
import FirebaseFirestore

struct WorkoutSession: Codable,Hashable {
    var workoutName: String
    var elapsedTime: String
    var date: String
    
}

struct WorkoutHistory: Codable {
    var date: Date
    var duration: TimeInterval
    // Add any other relevant properties you want to store
}

struct HomeView: View {
    @State private var selectedTabs: Tabs = .Home
    @State private var searchText = ""
    @State private var workoutHistory: [WorkoutSession] = []
    var sortedWorkoutHistory: [WorkoutSession] {
           return workoutHistory.sorted(by: { $0.date > $1.date })
       }
    
    
    var body: some View {
        NavigationView {
            VStack {
                
                Group{
                    if workoutHistory.isEmpty{
                        Text("Yours workout will be logged here!")
                        
                    }
                    else{
                        List {
                            ForEach(sortedWorkoutHistory.filter { workout in
                                searchText.isEmpty || workout.date.localizedStandardContains(searchText)
                            }, id: \.self) { workout in
                                HStack {
                                    VStack{
                                        Image(systemName: "calendar.circle.fill")
                                            //.foregroundColor(.black)
                                            .font(.system(size: 20))
                                        Spacer().frame(height: 10)
                                        Image(systemName: "dumbbell")
                                            .foregroundColor(.red)
                                            .font(.system(size: 20))
                                        //  Image(systemName: "clock")
                                        //    .foregroundColor(.gray)
                                    }
                                    
                                    VStack(alignment: .leading) {
                                        Text("\(workout.date)")
                                            .font(.system(size: 20))
                                        Text("\(workout.workoutName)")
                                            .font(.system(size: 20))
                                        Text("Duration:\(workout.elapsedTime)")
                                            .font(.system(size: 20))
                                    }
                                    Spacer()
                                    Image(systemName: "clock")
                                        .foregroundColor(.gray)
                                        .font(.system(size: 20))
                                    /*  Spacer()
                                     Image("back-bi")
                                     .resizable()
                                     .scaledToFit()
                                     .frame(height: 120)
                                     .cornerRadius(10)
                                     .padding(.vertical,5)
                                     */
                                    
                                    
                                }
                                .contextMenu{
                                    Button {
                                        deleteWorkout(workout)
                                    } label: {
                                        HStack{
                                            Image(systemName: "trash")
                                            Text("Delete!")
                                                .foregroundColor(.red)
                                        }
                                    }

                                }
                            }
                        }
                        .listStyle(InsetGroupedListStyle())
                       // .padding(.top)
                    }
                }
                
                
            }
            .navigationTitle("Workout History")
        }
        .onAppear {
            fetchWorkoutHistory()
        }
        .searchable(text: $searchText, prompt: "Search Date")
    }
    func fetchWorkoutHistory() {
        guard let user = Auth.auth().currentUser else {
            print("User not authenticated.")
            return
        }
        
        let db = Firestore.firestore()
        let sanitizedEmail = user.email?.replacingOccurrences(of: ".", with: "_").replacingOccurrences(of: "@", with: "_") ?? "unknown_email"
        
        db.collection("Session").document(sanitizedEmail).collection("Workouts").getDocuments { snapshot, error in
            if let error = error {
                print("Error fetching workout history: \(error.localizedDescription)")
            } else {
                workoutHistory = snapshot?.documents.compactMap { document in
                    do {
                        let jsonData = try JSONSerialization.data(withJSONObject: document.data(), options: [])
                        let decoder = JSONDecoder()
                        let workoutData = try decoder.decode(WorkoutSession.self, from: jsonData)
                        return workoutData
                    } catch let error {
                        print("Error decoding workout data: \(error.localizedDescription)")
                        return nil
                    }
                } ?? []
            }
        }
    }
    func deleteWorkout(_ workout: WorkoutSession) {
        // Step 1: Delete locally
        if let index = workoutHistory.firstIndex(of: workout) {
            workoutHistory.remove(at: index)
        }
        
        // Step 2: Delete from Firebase
        guard let user = Auth.auth().currentUser else {
            print("User not authenticated.")
            return
        }
        
        let db = Firestore.firestore()
        let sanitizedEmail = user.email?.replacingOccurrences(of: ".", with: "_").replacingOccurrences(of: "@", with: "_") ?? "unknown_email"
        
        db.collection("Session").document(sanitizedEmail).collection("Workouts")
            .whereField("date", isEqualTo: workout.date)
            .getDocuments { snapshot, error in
                if let error = error {
                    print("Error fetching workout documents: \(error.localizedDescription)")
                    return
                }
                
                for document in snapshot?.documents ?? [] {
                    db.collection("Session").document(sanitizedEmail).collection("Workouts").document(document.documentID).delete() { error in
                        if let error = error {
                            print("Error deleting workout document: \(error.localizedDescription)")
                        }
                    }
                }
            }
    }

}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
        
    }
}
