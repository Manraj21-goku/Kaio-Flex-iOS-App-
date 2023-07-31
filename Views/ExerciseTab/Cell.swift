//
//  Cell.swift
//  Kaio
//
//  Created by Manraj Singh on 23/07/23.
//

import SwiftUI
import Firebase
import FirebaseAuth
import FirebaseCore
import FirebaseFirestoreSwift

struct workinfo{
    @State  var Sets: String
    @State  var reps: String
    @State  var Sets1: String
    @State  var reps1: String
    @State  var Sets2: String
    @State  var reps2: String
    @State  var Sets3: String
    @State  var reps3: String
    func saveworkout(){
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

    }
}

struct Cell: View {
    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
    }
}

struct Cell_Previews: PreviewProvider {
    static var previews: some View {
        Cell()
    }
}
struct workCell: View{
  
    @State  var Sets: String
    @State  var reps: String
    @State  var Sets1: String
    @State  var reps1: String
    @State  var Sets2: String
    @State  var reps2: String
    @State  var Sets3: String
    @State  var reps3: String
    @State  var remem1 = false
    @State  var remem2 = false
    @State var remem3 = false
    @State  var remem4 = false
    @State private var navigateToWorkout = false
    var video: Video
    var body: some View{
        VStack(){
            Text(video.one)
                .font(.headline)
                .fontWeight(.bold)
            HStack{
               // Spacer()
                Text("Sets")
                Spacer()
                Text("Kgs")
                Text("Reps")
                Spacer()
                Spacer()
                
            }

            HStack{
                Text("1")
                    .padding(.trailing)
                TextField("Kgs",text: $Sets)
                    .padding(.leading,70)
                TextField("Reps",text: $reps)
                Toggle("",isOn: $remem1)
                    .toggleStyle(CheckBoxToggleStyle())
                
            }
            HStack{
                Text("2")
                    .padding(.trailing)
                TextField("Kgs",text: $Sets1)
                    .padding(.leading,70)
                TextField("Reps",text: $reps1)
                
                Toggle("",isOn: $remem2)
                    .toggleStyle(CheckBoxToggleStyle())
            }
            HStack{
                Text("3")
                    .padding(.trailing)
                TextField("Kgs",text: $Sets2)
                    .padding(.leading,70)
                TextField("Reps",text: $reps2)
                Toggle("",isOn: $remem3)
                    .toggleStyle(CheckBoxToggleStyle())
            }
            HStack{
                Text("4")
                    .padding(.trailing)
                TextField("Kgs",text: $Sets3)
                    .padding(.leading,70)
                TextField("Reps",text: $reps3)
                Toggle("",isOn: $remem4)
                    .toggleStyle(CheckBoxToggleStyle())
                    .onChange(of: remem1) { newValue in
                        if newValue{
                            saveuser()
                        }
                    }
                    
             
            }
            
        }
        
        /*Button {
            navigateToWorkout = true
        } label: {
            Text("End Workout")
            .bold()
            .font(.title2)
            .frame(width: 280,height: 50)
            .background(Color(.systemRed))
            .foregroundColor(.white)
            .cornerRadius(10)
        }*/
        .fullScreenCover(isPresented: $navigateToWorkout) {
            //Start_WorkoutVIEW()
            MainView()
        }
    }
    func saveuser() {
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
    }
}

struct workCell2: View{
    @State  var Sets: String
    @State  var reps: String
    @State  var Sets1: String
    @State  var reps1: String
    @State  var Sets2: String
    @State  var reps2: String
    @State  var Sets3: String
    @State  var reps3: String
    @State  var remem1 = false
    @State  var remem2 = false
    @State  var remem3 = false
    @State  var remem4 = false
    @State private var navigateToWorkout = false
    var video: Video
    var body: some View{
        VStack(){
            Text(video.two)
                .font(.headline)
                .fontWeight(.bold)
            HStack{
               // Spacer()
                Text("Sets")
                Spacer()
                Text("Kgs")
                Text("Reps")
                Spacer()
                Spacer()
                
            }

            HStack{
                Text("1")
                    .padding(.trailing)
                TextField("Kgs",text: $Sets)
                    .padding(.leading,70)
                TextField("Reps",text: $reps)
                Toggle("",isOn: $remem1)
                    .toggleStyle(CheckBoxToggleStyle())
                
            }
            HStack{
                Text("2")
                    .padding(.trailing)
                TextField("Kgs",text: $Sets1)
                    .padding(.leading,70)
                TextField("Reps",text: $reps1)
                
                Toggle("",isOn: $remem2)
                    .toggleStyle(CheckBoxToggleStyle())
            }
            HStack{
                Text("3")
                    .padding(.trailing)
                TextField("Kgs",text: $Sets2)
                    .padding(.leading,70)
                TextField("Reps",text: $reps2)
                Toggle("",isOn: $remem3)
                    .toggleStyle(CheckBoxToggleStyle())
            }
            HStack{
                Text("4")
                    .padding(.trailing)
                TextField("Kgs",text: $Sets3)
                    .padding(.leading,70)
                TextField("Reps",text: $reps3)
                Toggle("",isOn: $remem4)
                    .toggleStyle(CheckBoxToggleStyle())
                    .onChange(of: remem1) { newValue in
                        if newValue{
                            saveuser()
                        }
                    }
            }
            
        }
        
        /*Button {
            navigateToWorkout = true
        } label: {
            Text("End Workout")
            .bold()
            .font(.title2)
            .frame(width: 280,height: 50)
            .background(Color(.systemRed))
            .foregroundColor(.white)
            .cornerRadius(10)
        }*/
        .fullScreenCover(isPresented: $navigateToWorkout) {
            //Start_WorkoutVIEW()
            MainView()
        }
    }
    func saveuser() {
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
    }
}

struct workCell3: View{
    @State  var Sets: String
    @State  var reps: String
    @State  var Sets1: String
    @State  var reps1: String
    @State  var Sets2: String
    @State  var reps2: String
    @State  var Sets3: String
    @State  var reps3: String
    @State  var remem1 = false
    @State  var remem2 = false
    @State  var remem3 = false
    @State  var remem4 = false
    @State private var navigateToWorkout = false
    var video: Video
    var body: some View{
        VStack(){
            Text(video.three)
                .font(.headline)
                .fontWeight(.bold)
            HStack{
               // Spacer()
                Text("Sets")
                Spacer()
                Text("Kgs")
                Text("Reps")
                Spacer()
                Spacer()
                
            }

            HStack{
                Text("1")
                    .padding(.trailing)
                TextField("Kgs",text: $Sets)
                    .padding(.leading,70)
                TextField("Reps",text: $reps)
                Toggle("",isOn: $remem1)
                    .toggleStyle(CheckBoxToggleStyle())
                
            }
            HStack{
                Text("2")
                    .padding(.trailing)
                TextField("Kgs",text: $Sets1)
                    .padding(.leading,70)
                TextField("Reps",text: $reps1)
                
                Toggle("",isOn: $remem2)
                    .toggleStyle(CheckBoxToggleStyle())
            }
            HStack{
                Text("3")
                    .padding(.trailing)
                TextField("Kgs",text: $Sets2)
                    .padding(.leading,70)
                TextField("Reps",text: $reps2)
                Toggle("",isOn: $remem3)
                    .toggleStyle(CheckBoxToggleStyle())
            }
            HStack{
                Text("4")
                    .padding(.trailing)
                TextField("Kgs",text: $Sets3)
                    .padding(.leading,70)
                TextField("Reps",text: $reps3)
                Toggle("",isOn: $remem4)
                    .toggleStyle(CheckBoxToggleStyle())
                    .onChange(of: remem1) { newValue in
                        if newValue{
                            saveuser()
                        }
                    }
            }
            
        }
        
        /*Button {
            navigateToWorkout = true
        } label: {
            Text("End Workout")
            .bold()
            .font(.title2)
            .frame(width: 280,height: 50)
            .background(Color(.systemRed))
            .foregroundColor(.white)
            .cornerRadius(10)
        }*/
        .fullScreenCover(isPresented: $navigateToWorkout) {
            //Start_WorkoutVIEW()
            MainView()
        }
    }
    func saveuser() {
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
    }
}

struct workCell4: View{
    @State  var Sets: String
    @State  var reps: String
    @State  var Sets1: String
    @State  var reps1: String
    @State  var Sets2: String
    @State  var reps2: String
    @State  var Sets3: String
    @State  var reps3: String
    @State  var remem1 = false
    @State  var remem2 = false
    @State  var remem3 = false
    @State  var remem4 = false
    @State private var navigateToWorkout = false
    var video: Video
    var body: some View{
        VStack(){
            Text(video.four)
                .font(.headline)
                .fontWeight(.bold)
            HStack{
               // Spacer()
                Text("Sets")
                Spacer()
                Text("Kgs")
                Text("Reps")
                Spacer()
                Spacer()
                
            }

            HStack{
                Text("1")
                    .padding(.trailing)
                TextField("Kgs",text: $Sets)
                    .padding(.leading,70)
                TextField("Reps",text: $reps)
                Toggle("",isOn: $remem1)
                    .toggleStyle(CheckBoxToggleStyle())
                
            }
            HStack{
                Text("2")
                    .padding(.trailing)
                TextField("Kgs",text: $Sets1)
                    .padding(.leading,70)
                TextField("Reps",text: $reps1)
                
                Toggle("",isOn: $remem2)
                    .toggleStyle(CheckBoxToggleStyle())
            }
            HStack{
                Text("3")
                    .padding(.trailing)
                TextField("Kgs",text: $Sets2)
                    .padding(.leading,70)
                TextField("Reps",text: $reps2)
                Toggle("",isOn: $remem3)
                    .toggleStyle(CheckBoxToggleStyle())
            }
            HStack{
                Text("4")
                    .padding(.trailing)
                TextField("Kgs",text: $Sets3)
                    .padding(.leading,70)
                TextField("Reps",text: $reps3)
                Toggle("",isOn: $remem4)
                    .toggleStyle(CheckBoxToggleStyle())
                    .onChange(of: remem1) { newValue in
                        if newValue{
                            saveuser()
                        }
                    }
            }
            
        }
        
        /*Button {
            navigateToWorkout = true
        } label: {
            Text("End Workout")
            .bold()
            .font(.title2)
            .frame(width: 280,height: 50)
            .background(Color(.systemRed))
            .foregroundColor(.white)
            .cornerRadius(10)
        }*/
        .fullScreenCover(isPresented: $navigateToWorkout) {
            //Start_WorkoutVIEW()
            MainView()
        }
    }
    func saveuser() {
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
    }
}

struct workCell5: View{
    @State  var Sets: String
    @State  var reps: String
    @State  var Sets1: String
    @State  var reps1: String
    @State  var Sets2: String
    @State  var reps2: String
    @State  var Sets3: String
    @State  var reps3: String
    @State  var remem1 = false
    @State  var remem2 = false
    @State  var remem3 = false
    @State  var remem4 = false
    @State private var navigateToWorkout = false
    var video: Video
    var body: some View{
        VStack(){
            Text(video.five)
                .font(.headline)
                .fontWeight(.bold)
            HStack{
               // Spacer()
                Text("Sets")
                Spacer()
                Text("Kgs")
                Text("Reps")
                Spacer()
                Spacer()
                
            }

            HStack{
                Text("1")
                    .padding(.trailing)
                TextField("Kgs",text: $Sets)
                    .padding(.leading,70)
                TextField("Reps",text: $reps)
                Toggle("",isOn: $remem1)
                    .toggleStyle(CheckBoxToggleStyle())
                
            }
            HStack{
                Text("2")
                    .padding(.trailing)
                TextField("Kgs",text: $Sets1)
                    .padding(.leading,70)
                TextField("Reps",text: $reps1)
                
                Toggle("",isOn: $remem2)
                    .toggleStyle(CheckBoxToggleStyle())
            }
            HStack{
                Text("3")
                    .padding(.trailing)
                TextField("Kgs",text: $Sets2)
                    .padding(.leading,70)
                TextField("Reps",text: $reps2)
                Toggle("",isOn: $remem3)
                    .toggleStyle(CheckBoxToggleStyle())
            }
            HStack{
                Text("4")
                    .padding(.trailing)
                TextField("Kgs",text: $Sets3)
                    .padding(.leading,70)
                TextField("Reps",text: $reps3)
                Toggle("",isOn: $remem4)
                    .toggleStyle(CheckBoxToggleStyle())
                    .onChange(of: remem1) { newValue in
                        if newValue{
                            saveuser()
                        }
                    }
            }
            
        }
        
        /*Button {
            navigateToWorkout = true
        } label: {
            Text("End Workout")
            .bold()
            .font(.title2)
            .frame(width: 280,height: 50)
            .background(Color(.systemRed))
            .foregroundColor(.white)
            .cornerRadius(10)
        }*/
        .fullScreenCover(isPresented: $navigateToWorkout) {
            //Start_WorkoutVIEW()
            MainView()
        }
    }
    func saveuser() {
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
    }
}

struct workCell6: View{
    @State  var Sets: String
    @State  var reps: String
    @State  var Sets1: String
    @State  var reps1: String
    @State  var Sets2: String
    @State  var reps2: String
    @State  var Sets3: String
    @State  var reps3: String
    @State  var remem1 = false
    @State  var remem2 = false
    @State  var remem3 = false
    @State  var remem4 = false
    @State private var navigateToWorkout = false
    var video: Video
    var body: some View{
        VStack(){
            Text(video.six)
                .font(.headline)
                .fontWeight(.bold)
            HStack{
               // Spacer()
                Text("Sets")
                Spacer()
                Text("Kgs")
                Text("Reps")
                Spacer()
                Spacer()
                
            }

            HStack{
                Text("1")
                    .padding(.trailing)
                TextField("Kgs",text: $Sets)
                    .padding(.leading,70)
                TextField("Reps",text: $reps)
                Toggle("",isOn: $remem1)
                    .toggleStyle(CheckBoxToggleStyle())
                
            }
            HStack{
                Text("2")
                    .padding(.trailing)
                TextField("Kgs",text: $Sets1)
                    .padding(.leading,70)
                TextField("Reps",text: $reps1)
                
                Toggle("",isOn: $remem2)
                    .toggleStyle(CheckBoxToggleStyle())
            }
            HStack{
                Text("3")
                    .padding(.trailing)
                TextField("Kgs",text: $Sets2)
                    .padding(.leading,70)
                TextField("Reps",text: $reps2)
                Toggle("",isOn: $remem3)
                    .toggleStyle(CheckBoxToggleStyle())
            }
            HStack{
                Text("4")
                    .padding(.trailing)
                TextField("Kgs",text: $Sets3)
                    .padding(.leading,70)
                TextField("Reps",text: $reps3)
                Toggle("",isOn: $remem4)
                    .toggleStyle(CheckBoxToggleStyle())
                    .onChange(of: remem1) { newValue in
                        if newValue{
                            saveuser()
                        }
                    }
            }
            
        }
        
        /*Button {
            navigateToWorkout = true
        } label: {
            Text("End Workout")
            .bold()
            .font(.title2)
            .frame(width: 280,height: 50)
            .background(Color(.systemRed))
            .foregroundColor(.white)
            .cornerRadius(10)
        }*/
        .fullScreenCover(isPresented: $navigateToWorkout) {
            //Start_WorkoutVIEW()
            MainView()
        }
    }
    func saveuser() {
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
    }
}

struct workCell7: View{
    @State  var Sets: String
    @State  var reps: String
    @State  var Sets1: String
    @State  var reps1: String
    @State  var Sets2: String
    @State  var reps2: String
    @State  var Sets3: String
    @State  var reps3: String
    @State  var remem1 = false
    @State  var remem2 = false
    @State  var remem3 = false
    @State  var remem4 = false
    @State private var navigateToWorkout = false
    var video: Video
    var body: some View{
        VStack(){
            Text(video.seven)
                .font(.headline)
                .fontWeight(.bold)
            HStack{
               // Spacer()
                Text("Sets")
                Spacer()
                Text("Kgs")
                Text("Reps")
                Spacer()
                Spacer()
                
            }

            HStack{
                Text("1")
                    .padding(.trailing)
                TextField("Kgs",text: $Sets)
                    .padding(.leading,70)
                TextField("Reps",text: $reps)
                Toggle("",isOn: $remem1)
                    .toggleStyle(CheckBoxToggleStyle())
                
            }
            HStack{
                Text("2")
                    .padding(.trailing)
                TextField("Kgs",text: $Sets1)
                    .padding(.leading,70)
                TextField("Reps",text: $reps1)
                
                Toggle("",isOn: $remem2)
                    .toggleStyle(CheckBoxToggleStyle())
            }
            HStack{
                Text("3")
                    .padding(.trailing)
                TextField("Kgs",text: $Sets2)
                    .padding(.leading,70)
                TextField("Reps",text: $reps2)
                Toggle("",isOn: $remem3)
                    .toggleStyle(CheckBoxToggleStyle())
            }
            HStack{
                Text("4")
                    .padding(.trailing)
                TextField("Kgs",text: $Sets3)
                    .padding(.leading,70)
                TextField("Reps",text: $reps3)
                Toggle("",isOn: $remem4)
                    .toggleStyle(CheckBoxToggleStyle())
                    .onChange(of: remem1) { newValue in
                        if newValue{
                            saveuser()
                        }
                    }
            }
            
        }
        
        /*Button {
            navigateToWorkout = true
        } label: {
            Text("End Workout")
            .bold()
            .font(.title2)
            .frame(width: 280,height: 50)
            .background(Color(.systemRed))
            .foregroundColor(.white)
            .cornerRadius(10)
        }*/
        .fullScreenCover(isPresented: $navigateToWorkout) {
            //Start_WorkoutVIEW()
            MainView()
        }
    }
    func saveuser() {
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
    }
}

struct workCell8: View{
    @State  var Sets: String
    @State  var reps: String
    @State  var Sets1: String
    @State  var reps1: String
    @State  var Sets2: String
    @State  var reps2: String
    @State  var Sets3: String
    @State  var reps3: String
    @State  var remem1 = false
    @State  var remem2 = false
    @State  var remem3 = false
    @State  var remem4 = false
    @State private var navigateToWorkout = false
    var video: Video
    var body: some View{
        VStack(){
            Text(video.eight)
                .font(.headline)
                .fontWeight(.bold)
            HStack{
               // Spacer()
                Text("Sets")
                Spacer()
                Text("Kgs")
                Text("Reps")
                Spacer()
                Spacer()
                
            }

            HStack{
                Text("1")
                    .padding(.trailing)
                TextField("Kgs",text: $Sets)
                    .padding(.leading,70)
                TextField("Reps",text: $reps)
                Toggle("",isOn: $remem1)
                    .toggleStyle(CheckBoxToggleStyle())
                
            }
            HStack{
                Text("2")
                    .padding(.trailing)
                TextField("Kgs",text: $Sets1)
                    .padding(.leading,70)
                TextField("Reps",text: $reps1)
                
                Toggle("",isOn: $remem2)
                    .toggleStyle(CheckBoxToggleStyle())
            }
            HStack{
                Text("3")
                    .padding(.trailing)
                TextField("Kgs",text: $Sets2)
                    .padding(.leading,70)
                TextField("Reps",text: $reps2)
                Toggle("",isOn: $remem3)
                    .toggleStyle(CheckBoxToggleStyle())
            }
            HStack{
                Text("4")
                    .padding(.trailing)
                TextField("Kgs",text: $Sets3)
                    .padding(.leading,70)
                TextField("Reps",text: $reps3)
                Toggle("",isOn: $remem4)
                    .toggleStyle(CheckBoxToggleStyle())
                    .onChange(of: remem1) { newValue in
                        if newValue{
                            saveuser()
                        }
                    }
            }
            
        }
        
        /*Button {
            navigateToWorkout = true
        } label: {
            Text("End Workout")
            .bold()
            .font(.title2)
            .frame(width: 280,height: 50)
            .background(Color(.systemRed))
            .foregroundColor(.white)
            .cornerRadius(10)
        }*/
        .fullScreenCover(isPresented: $navigateToWorkout) {
            //Start_WorkoutVIEW()
            MainView()
        }
    }
    func saveuser() {
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
    }
}
