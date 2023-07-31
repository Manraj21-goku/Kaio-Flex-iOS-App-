//
//  Measure Tab.swift
//  Kaio
//
//  Created by Manraj Singh on 17/07/23.
//

import SwiftUI
import Firebase
import FirebaseAuth
import FirebaseCore
import FirebaseStorage
import FirebaseFirestore
import FirebaseFirestoreSwift


struct UserData: Codable {
    var weight:String
    var height: String
    var neck: String
    var shoulder: String
    var chest: String
    var bicep: String
    var forearm: String
    var abd: String
    var hip: String
    var quad: String
    var calf: String
    var birthdate: String
}

struct Measure_Tab: View {
    @State private var userData: UserData?  // Store the fetched UserData object
    @State private var isDataLoaded = false
    @State private var userData2: User?
    @State private var isDataLoaded2 = false
    @State private var name = ""
    @State private var email = ""
    @State private var weight = ""
    @State private var height = ""
    @State private var neck = ""
    @State private var shoulder = ""
    @State private var chest = ""
    @State private var bicep = ""
    @State private var forearm = ""
    @State private var abd = ""
    @State private var hip = ""
    @State private var quad = ""
    @State private var calf = ""
    @State private var bod = Date()
    var body: some View {
        NavigationView{
            Form{
                Section(header: Text("Personal Information")){
                    //TextField("Name",text: $name)
                    //  TextField("Email",text: $email)
                    Text(name)
                    Text(email)
                    
                    DatePicker("Birthdate",selection: $bod,displayedComponents: .date)
                    TextField("Weight",text: $weight)
                        .placeholder(when: isDataLoaded) {
                            Text(weight)
                        }
                    TextField("Height",text: $height)
                        .placeholder(when: isDataLoaded) {
                            Text(height)
                        }
                
                    
                }
                Section(header: Text("Body")){
                    TextField("Neck",text: $neck)
                        .placeholder(when: isDataLoaded) {
                            Text(neck)
                        }
                    TextField("Shoulder",text: $shoulder)
                        .placeholder(when: isDataLoaded) {
                            Text(shoulder)
                        }
                    TextField("Chest",text: $chest)
                        .placeholder(when: isDataLoaded) {
                            Text(chest)
                        }
                    TextField("Bicep",text: $bicep)
                        .placeholder(when: isDataLoaded) {
                            Text(bicep)
                        }
                    TextField("Forearm",text: $forearm)
                        .placeholder(when: isDataLoaded) {
                            Text(forearm)
                        }
                    TextField("Abdomen",text: $abd)
                        .placeholder(when: isDataLoaded) {
                            Text(abd)
                        }
                    TextField("Hip",text: $hip)
                        .placeholder(when: isDataLoaded) {
                            Text(hip)
                        }
                    TextField("Quads",text: $quad)
                        .placeholder(when: isDataLoaded) {
                            Text(quad)
                        }
                    TextField("Calf",text: $calf)
                        .placeholder(when: isDataLoaded) {
                            Text(calf)
                        }
                  //  TextField("Chest",text: isDataLoaded ? $chest : .constant(""))
                    //TextField("Bicep",text: isDataLoaded ? $bicep : .constant(""))
                  //  TextField("Forearm",text: isDataLoaded ? $forearm : .constant(""))
                   // TextField("Abdomen",text: isDataLoaded ? $abd : .constant(""))
                 //   TextField("Hip",text: isDataLoaded ? $hip : .constant(""))
                   // TextField("Quad",text: isDataLoaded ? $quad : .constant(""))
                    //TextField("Calf",text: isDataLoaded ? $calf : .constant(""))
                    //TextField("body",text : $calf)
                }
                
            }
            .accentColor(.red)
            .navigationTitle("Measurment")
            .toolbar{
                ToolbarItemGroup(placement: .navigationBarTrailing) {
                  

                    Button {
                        cm_inch()
                    } label: {
                        Text("CM")
                        Image(systemName: "ruler.fill")
                        
                    }
                    Button("Save",action :saveuser)
                }
            }
            .onAppear{
                loadData()
                loadData2()
            }
            .onTapGesture {
                hideKeyboard()
                
            }
        }
    }
    func saveuser() {
        guard let user = Auth.auth().currentUser else {
            print("User not authenticated.")
            return
        }
        
        let db = Firestore.firestore()
        let userDocRef = db.collection("Users").document(user.email!)
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd/MM/yyyy"
        let birthdateString = dateFormatter.string(from: bod)
        
        
        let userData = UserData(weight: weight, height: height, neck: neck, shoulder: shoulder, chest: chest, bicep: bicep, forearm: forearm, abd: abd, hip: hip, quad: quad, calf: calf,birthdate: birthdateString)
        
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
    func loadData2(){
        guard let user = Auth.auth().currentUser else {
            print("User not authenticated.")
            return
        }
        
        let db = Firestore.firestore()
        let userDocRef = db.collection("Usersinfo").document(user.email!)
        
        userDocRef.getDocument { document, error in
            if let document = document, document.exists {
                do {
                    // Decode Firestore document to UserData object
                    self.userData2 = try document.data(as: User.self) // Direct assignment without optional binding
                    
                    DispatchQueue.main.async {
                        self.isDataLoaded2 = true
                        update()
                       
                    }
                } catch {
                    print("Error decoding user data: \(error.localizedDescription)")
                }
            } else {
                print("Document does not exist")
            }
        }
    }
    func loadData() {
        guard let user = Auth.auth().currentUser else {
            print("User not authenticated.")
            return
        }
        
        let db = Firestore.firestore()
        let userDocRef = db.collection("Users").document(user.email!)
        
        userDocRef.getDocument { document, error in
            if let document = document, document.exists {
                do {
                    // Decode Firestore document to UserData object
                    self.userData = try document.data(as: UserData.self) // Direct assignment without optional binding
                    
                    DispatchQueue.main.async {
                        self.isDataLoaded = true
                        updateFormWithLoadedData()
                    }
                } catch {
                    print("Error decoding user data: \(error.localizedDescription)")
                }
            } else {
                print("Document does not exist")
            }
        }
    }
    func update(){
        if let userData2 = userData2{
            name = userData2.name
            email = userData2.email
        }
    }
    func updateFormWithLoadedData() {
        // Check if userData is loaded and update the fields accordingly
        if let userData = userData {
            weight = userData.weight
            height = userData.height
            neck = userData.neck
            shoulder = userData.shoulder
            chest = userData.chest
            bicep = userData.bicep
            forearm = userData.forearm
            abd = userData.abd
            hip = userData.hip
            quad = userData.quad
            calf = userData.calf
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "dd/MM/yyyy"
            if let date = dateFormatter.date(from: userData.birthdate) {
                bod = date
            }
        }
    }
    func cm_inch() {
        if let n = Double(userData?.neck ?? ""),
            let s = Double(userData?.shoulder ?? ""),
            let c = Double(userData?.chest ?? ""),
            let b = Double(userData?.bicep ?? ""),
            let f = Double(userData?.forearm ?? ""),
            let ab = Double(userData?.abd ?? ""),
            let hi = Double(userData?.hip ?? ""),
            let qu = Double(userData?.quad ?? ""),
            let ca = Double(userData?.calf ?? "") {
            
            userData?.neck = String(n * 2.54) + "cm"
            userData?.shoulder = String(s * 2.54) + "cm"
            userData?.chest = String(c * 2.54) + "cm"
            userData?.bicep = String(b * 2.54) + "cm"
            userData?.forearm = String(f * 2.54) + "cm"
            userData?.abd = String(ab * 2.54) + "cm"
            userData?.hip = String(hi * 2.54) + "cm"
            userData?.quad = String(qu * 2.54) + "cm"
            userData?.calf = String(ca * 2.54) + "cm"
            neck = userData!.neck
            shoulder = userData!.shoulder
            chest = userData!.chest
            bicep = userData!.bicep
            forearm = userData!.forearm
            abd = userData!.abd
            hip = userData!.hip
            quad = userData!.quad
            calf = userData!.calf
        } else {
            // Handle the case where the conversion fails gracefully (e.g., display an error message or provide default values)
            print("Error: One or more measurements are not valid numbers.")
        }
    }
    func inch_cm() {
        if let n = Double(neck ),
           let s = Double(shoulder ),
           let c = Double(chest ),
           let b = Double(bicep ),
           let f = Double(forearm ),
            let ab = Double(abd),
            let hi = Double(hip),
            let qu = Double(quad),
            let ca = Double(calf) {
            
            userData?.neck = String(n / 2.54) + "inch"
            userData?.shoulder = String(s / 2.54) + "inch"
            userData?.chest = String(c / 2.54) + "inch"
            userData?.bicep = String(b / 2.54) + "inch"
            userData?.forearm = String(f / 2.54) + "inch"
            userData?.abd = String(ab / 2.54) + "inch"
            userData?.hip = String(hi / 2.54) + "inch"
            userData?.quad = String(qu / 2.54) + "inch"
            userData?.calf = String(ca / 2.54) + "inch"
            neck = userData!.neck
            shoulder = userData!.shoulder
            chest = userData!.chest
            bicep = userData!.bicep
            forearm = userData!.forearm
            abd = userData!.abd
            hip = userData!.hip
            quad = userData!.quad
            calf = userData!.calf
        } else {
            // Handle the case where the conversion fails gracefully (e.g., display an error message or provide default values)
            print("Error: One or more measurements are not valid numbers.")
        }
    }


    
    
    
}


struct Measure_Tab_Previews: PreviewProvider {
    static var previews: some View {
        Measure_Tab()
    }
}

#if canImport(UIKit)
extension View {
    func hideKeyboard(){
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}
#endif
//

