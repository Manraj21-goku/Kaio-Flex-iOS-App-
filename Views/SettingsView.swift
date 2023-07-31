//
//  SettingsView.swift
//  Kaio
//
//  Created by Manraj Singh on 17/07/23.
//

import SwiftUI
import Firebase
import FirebaseAuth
import FirebaseStorage
import FirebaseFirestore
@available(iOS 16.0, *)
struct SettingsView: View {
    @AppStorage("isDarkMode") private var isDarkMode = false
    
    @State private var music = true
    @State private var retrievedImages : UIImage?
    @State private var image = UIImage()
    @State private var showSheet = false
    @State private var showPicker: Bool = false
    @State private var croppedImage: UIImage?
    @State private var storedCroppedImage: UIImage?
    @State private var showingConfirmation = false
    @State private var showingDeleteConfirmation = false
    @State private var navigateToLogin = false
    @State private var userData2: User?
    @State private var isDataLoaded2 = false
    @State private var name = ""
    @State private var email = ""
    @State private var userEmail = ""
    
    var body: some View {
        NavigationView {
           
            Form{
                Section(header: Text("User Info")){
                    
                    ZStack(alignment: .bottomTrailing){
                        if let retrievedImages {
                            Image(uiImage: retrievedImages)
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 100,height: 100)
                                .clipShape(Circle())
                                
                        } else{
                            Button{
                               // showPicker
                            }label: {
                                Image(uiImage: UIImage(systemName: "person.fill")!)
                                     .resizable()
                                     .cornerRadius(50)
                                     .frame(width: 100,height: 100)
                                     .background(Color.black.opacity(0.2))
                                     .aspectRatio( contentMode: .fill)
                                     .clipShape(Circle())
                            }
                          

                           // Text("No image")
                              //  .font(.caption)
                                //.foregroundColor(.gray)
                                 
                        }
                        Button{
                            
                            showPicker.toggle()
                           
                        }label: {
                            Image(systemName: "plus")
                                .foregroundColor(.white)
                                .frame(width: 25,height: 25)
                                .background(Color.blue)
                                .clipShape(Circle())
                            
                        }
                           
                       

                       
                            
                      
                    }
                  //  .cropImagePicker(options: [.circle,.rectangle,.square], show: $showPicker, croppedImage: $croppedImage)
                   
                    if croppedImage != nil{
                        Button{
                            uploadPhoto()
                        } label: {
                            Text("Upload Photo")
                        }
                    }
                    Text(name)
                    NavigationLink(destination: Measure_Tab()) {
                        Label("Measure", systemImage: "ruler").foregroundColor(Color("Text"))
                        
                        
                    }
                    
                    
                    
                }
                .cropImagePicker(options: [.circle,.rectangle,.square], show: $showPicker, croppedImage: $croppedImage)
                Section(header: Text("Device Settings") //,footer: Text("System settings will override Dark Mode and use the current device theme")
                ){
                    Toggle("Dark Mode", isOn: $isDarkMode)
                 //   if isDarkMode
                    //Toggle("Music", isOn: $music)
                   
                    Button {
                        
                        showingConfirmation = true
                    } label: {
                        Text("Log Out")
                            .bold()
                            //.frame(width: 200,height: 40)
                            //.background(RoundedRectangle(cornerRadius: 10,style: .continuous)
                                //.fill(.linearGradient(colors: [.red], startPoint: .top, endPoint: .bottomTrailing))
                       //     )
                            .foregroundColor(.red)
                    }
                    Button {
                       
                        showingDeleteConfirmation = true
                    } label: {
                        Text("Delete Account")
                            .bold()
                           // .frame(width: 200,height: 40)
                         //   .background(RoundedRectangle(cornerRadius: 10,style: .continuous)
                          //      .fill(.linearGradient(colors: [.red], startPoint: .top, endPoint: .bottomTrailing))
                         //   )
                            .foregroundColor(.red)
                            .alert(isPresented: $showingDeleteConfirmation, content: {
                                Alert(title: Text("Delete Account"),message: Text("Are you sure to delete your account?"),primaryButton: .default(Text("Delete"),action: {
                                    deleteAccount()
                                    
                                }), secondaryButton: .cancel(Text("Cancel")))
                            })
                            
                    }
                    Text("Version: v.1.0")
                        .foregroundColor(.blue)
                }
                
            }
            .onAppear{
                if let userEmail = Auth.auth().currentUser?.email{
                    self.userEmail
                    retrievePhotos()
                }
               
                loadData2()
            
                
            }
            .navigationTitle("Settings")
          
            
            
            
            .alert(isPresented: $showingConfirmation, content: {
                Alert(title: Text("Log Out"),message: Text("Are you sure to logout?"),primaryButton: .default(Text("Yes"),action: {
                    logout()
                }), secondaryButton: .cancel(Text("No")))
            })
            .fullScreenCover(isPresented: $navigateToLogin) {
                Welcome()
            }
           
        }
        
    }
    
    func uploadPhoto() {
            guard let userEmail = Auth.auth().currentUser?.email, let croppedImage = croppedImage else {
                return
            }

            let storageRef = Storage.storage().reference()
            let imageData = croppedImage.jpegData(compressionQuality: 1)
            guard let imageData = imageData else {
                return
            }

            let path = "images/\(userEmail).jpg"
            let fileRef = storageRef.child(path)

            let uploadTask = fileRef.putData(imageData, metadata: nil) { metadata, error in
                if error == nil, let _ = metadata {
                    // Update the userImages collection with the photo path
                    let db = Firestore.firestore()
                    db.collection("userImages").document(userEmail).setData(["url": path]) { error in
                        if error == nil {
                            DispatchQueue.main.async {
                                self.retrievedImages = croppedImage
                            }
                        }
                    }
                }
            }
        }
    func retrievePhotos() {
            guard let userEmail = Auth.auth().currentUser?.email else {
                return
            }

            let db = Firestore.firestore()
            let userImageRef = db.collection("userImages").document(userEmail)

            userImageRef.getDocument { document, error in
                if let document = document, document.exists {
                    if let path = document["url"] as? String {
                        // Fetch the profile photo only for the logged-in user
                        let storageRef = Storage.storage().reference()
                        let fileRef = storageRef.child(path)

                        fileRef.getData(maxSize: 5 * 1024 * 1024) { data, error in
                            if error == nil, let data = data, let image = UIImage(data: data) {
                                DispatchQueue.main.async {
                                    self.retrievedImages = image
                                }
                            }
                        }
                    }
                }
            }
        }
    
    private func logout(){
        do{
            try Auth.auth().signOut()
            navigateToLogin = true
        }
        catch let signOutError as NSError {
            print("Error signing out: \(signOutError)")
        }
    }
    private func deleteAccount() {
        guard let currentUser = Auth.auth().currentUser else {
            print("User is not authenticated.")
            return
        }

        
        currentUser.delete { error in
            if let error = error {
                // Handle the account deletion error
                print("Error deleting account: \(error.localizedDescription)")
            } else {
                // Account deletion was successful
                print("Account deleted successfully.")
              navigateToLogin = true
            }
        }
    }
    func loadData2() {
        guard let user = Auth.auth().currentUser else {
            print("User not authenticated.")
            return
        }
        
        let db = Firestore.firestore()
        let userDocRef = db.collection("Usersinfo").document(user.email!)
        
        userDocRef.getDocument { document, error in
            if let error = error {
                print("Error fetching document: \(error)")
                return
            }
            
            if let document = document, document.exists {
                do {
                    // Decode Firestore document to UserData object
                    self.userData2 = try document.data(as: User.self) // Direct assignment without optional binding
                    
                    DispatchQueue.main.async {
                        self.isDataLoaded2 = true
                        self.update() // Call the update function here, not inside the trailing closure
                    }
                } catch {
                    print("Error decoding user data: \(error)")
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

}


@available(iOS 16.0, *)
struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView()
    }
}
