//
//  WorkoutTab.swift
//  Kaio
//
//  Created by Manraj Singh on 22/07/23.
//

import SwiftUI
import Firebase
import FirebaseAuth
import FirebaseCore
import FirebaseFirestoreSwift
import FirebaseStorage
import FirebaseFirestore


struct WorkoutSession: Codable,Hashable {
    var workoutName: String
    var elapsedTime: String
    var date: String
    
}



struct WorkoutInfo: Codable{
    var Sets: String
    var reps: String
    var Sets1: String
    var reps1: String
    var Sets2: String
    var reps2: String
    var Sets3: String
    var reps3: String
    
}

struct WorkoutTab: View {
    @State private var workoutHistory: [WorkoutHistory] = []
    @State  var Sets: String
    @State  var reps: String
    @State  var Sets1: String
    @State  var reps1: String
    @State  var Sets2: String
    @State  var reps2: String
    @State  var Sets3: String
    @State  var reps3: String
    @State private var startTime: Date?
    @State private var timer: Timer?
    @State private var elapsedTime: TimeInterval = 0
    @State private var isTimerRunning = false
    var b: Int
    var video: Video
    var videos : [Video] = Array(VideoList.topTen.prefix(6))
    
    @State private var navigateToWorkout = false
    var body: some View {
        let b = b
        
        
        
        NavigationView {
            List{
                ForEach(videos, id: \.id){video in
                    if b == 1{
                        workCell(Sets: "", reps: "",Sets1: "",reps1: "",Sets2: "",reps2: "",Sets3: "",reps3: "", video: video)
                            .navigationTitle("Chest and Triceps")
                    } else if b == 2{
                        workCell2(Sets: "", reps: "",Sets1: "",reps1: "",Sets2: "",reps2: "",Sets3: "",reps3: "", video: video)
                            
                            .navigationTitle("Back and Biceps")
                    }
                    else if b == 3{
                        workCell3(Sets: "", reps: "",Sets1: "",reps1: "",Sets2: "",reps2: "",Sets3: "",reps3: "", video: video)
                           
                            .navigationTitle("Legs and Shoulder")
                    }
                    else if b == 4{
                        workCell4(Sets: "", reps: "",Sets1: "",reps1: "",Sets2: "",reps2: "",Sets3: "",reps3: "", video: video)
                            .navigationTitle("Core")
                    }
                    else if b == 5{
                        workCell5(Sets: "", reps: "",Sets1: "",reps1: "",Sets2: "",reps2: "",Sets3: "",reps3: "", video: video)
                            .navigationTitle("Arms")
                    }
                    else if b == 6{
                        workCell6(Sets: "", reps: "",Sets1: "",reps1: "",Sets2: "",reps2: "",Sets3: "",reps3: "", video: video)
                          
                            .navigationTitle("Full-Body Workout 1")
                    }
                    else if b == 7{
                        workCell7(Sets: "", reps: "",Sets1: "",reps1: "",Sets2: "",reps2: "",Sets3: "",reps3: "", video: video)
                           
                            .navigationTitle("Full-Body Workout 2")
                    }
                    else if b == 8{
                        workCell8(Sets: "", reps: "",Sets1: "",reps1: "",Sets2: "",reps2: "",Sets3: "",reps3: "", video: video)
                            .navigationTitle("Full-Body Workout 3")
                    }
                    
                }
            }
            
            
            // .navigationTitle("Workout")
            .toolbar{
                
                ToolbarItem(placement: .navigationBarLeading) {
                    Button {
                        navigateToWorkout = true
                    } label: {
                        Text("Cancel")
                            .bold()
                            .font(.title2)
                            .frame(width: 100,height:35)
                            .background(Color(.systemRed))
                            .foregroundColor(.white)
                            .cornerRadius(20)
                    }
                }
                ToolbarItem(placement: .bottomBar){
                    VStack{
                        
                        ZStack {
                            // Circular progress indicator
                            
                            Text(formattedTime(elapsedTime))
                                .font(.largeTitle)
                                .foregroundColor(.black)
                            Circle()
                                .stroke(Color.red.opacity(0.3), lineWidth: 10)
                            
                            Circle()
                                .trim(from: 0, to: min(CGFloat(elapsedTime / 3600), 1))
                                .stroke(Color.red, lineWidth: 10)
                                .rotationEffect(.degrees(-90))
                            
                            
                        }
                        .padding()
                        .animation(.linear)
                        
                    }
                }
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
                        if b == 1 {saveworkout2(workoutName: "Chest and Triceps")}
                        else if b == 2 {saveworkout2(workoutName: "Back and Biceps")}
                        else if b == 3 {saveworkout2(workoutName: "Legs and Shoulders")}
                        else if b == 4 {saveworkout2(workoutName: "Core")}
                        else if b == 5 {saveworkout2(workoutName: "Arms")}
                        else if b == 6 {saveworkout2(workoutName: "Full-Body Workout 1")}
                        else if b == 7 {saveworkout2(workoutName: "Full-Body Workout 2")}
                        else if b == 8 {saveworkout2(workoutName: "Full-Body Workout 3")}
                        
                        
                       
                        navigateToWorkout = true
                        
                    } label: {
                        Text("End")
                            .bold()
                            .font(.title2)
                            .frame(width: 100,height:35)
                            .background(Color(.systemGreen))
                            .foregroundColor(.white)
                            .cornerRadius(20)
                    }
                }
            }
            .fullScreenCover(isPresented: $navigateToWorkout) {
                //Start_WorkoutVIEW()
                MainView()
            }
            
        }
        .onAppear {
            
            // Start the timer when the view appears
            startTime = Date()
            timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { _ in
                if let startTime = startTime {
                    elapsedTime = Date().timeIntervalSince(startTime)
                }
            }
        }
        .onDisappear {
            // Stop the timer when the view disappears
            timer?.invalidate()
            timer = nil
            if let startTime = startTime {
                let timeSpent = Date().timeIntervalSince(startTime)
                print("You spent \(formattedTime(timeSpent)) on this page.")
            }
        }
    }
    func saveworkout2(workoutName: String) {
        guard let user = Auth.auth().currentUser else {
            print("User not authenticated.")
            return
        }

        let db = Firestore.firestore()
        let currentTime = Date().timeIntervalSince(startTime ?? Date())

        let workoutData = WorkoutSession(
            workoutName: workoutName,
            elapsedTime: formattedTime(currentTime),
            date: formattedDate(Date())
        )

        do {
            let encoder = JSONEncoder()
            let workoutDataData = try encoder.encode(workoutData)
            let workoutDataDict = try JSONSerialization.jsonObject(with: workoutDataData, options: []) as? [String: Any]

            // Use the user's email as the document ID (sanitize the email)
            let sanitizedEmail = user.email?.replacingOccurrences(of: ".", with: "_").replacingOccurrences(of: "@", with: "_") ?? "unknown_email"
            
            // Save workout data under the "Workouts" collection with the user's email as the document ID
            db.collection("Session").document(sanitizedEmail).collection("Workouts").addDocument(data: workoutDataDict ?? [:]) { error in
                if let error = error {
                    print("Error saving workout data: \(error.localizedDescription)")
                } else {
                    print("Workout data saved successfully.")
                }
            }
        } catch let error {
            print("Error encoding workout data: \(error.localizedDescription)")
        }
    }


    
    /* func saveworkout(){
     guard let user = Auth.auth().currentUser else {
     print("User not authenticated.")
     return
     }
     
     let db = Firestore.firestore()
     let userDocRef = db.collection("Workout").document(user.email!)
     
     
     
     let userData = WorkoutInfo(Sets: Sets, reps: reps, Sets1: Sets1, reps1: reps1, Sets2: Sets2, reps2: reps2, Sets3: Sets3, reps3: reps3)
     
     do {
     let encoder = JSONEncoder()
     let userDataData = try encoder.encode(userData)
     let userDataDict = try JSONSerialization.jsonObject(with: userDataData, options: []) as? [String: Any]
     
     userDocRef.setData(userDataDict ?? [:]) { error in
     if let error = error {
     print("Error saving user data: \(error.localizedDescription)")
     } else {
     print("User data saved successfully.")
     }
     }
     } catch let error {
     print("Error encoding user data: \(error.localizedDescription)")
     }
     
     }*/
    private func formattedTime(_ timeInterval: TimeInterval) -> String {
        let formatter = DateComponentsFormatter()
        formatter.allowedUnits = [.hour, .minute, .second]
        formatter.unitsStyle = .positional
        formatter.zeroFormattingBehavior = .pad
        return formatter.string(from: timeInterval) ?? "00:00:00"
    }
    private func formattedDate(_ date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd/MM/yy"
        return formatter.string(from: date)
    }
    
}

struct WorkoutTab_Previews: PreviewProvider {
    static var previews: some View {
        WorkoutTab( Sets: "", reps: "",Sets1: "",reps1: "",Sets2: "",reps2: "",Sets3: "",reps3: "", b: Int(1),video: VideoList.topTen.first!)
    }
}
