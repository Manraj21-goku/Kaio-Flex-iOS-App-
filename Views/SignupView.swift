//
//  SignupView.swift
//  Kaio
//
//  Created by Manraj Singh on 16/07/23.
//

import SwiftUI
import Firebase
import FirebaseAuth
import FirebaseCore
import FirebaseFirestoreSwift


struct User: Codable{
    var name: String
    var email: String
}
struct SignupView: View {
    @EnvironmentObject private var launchScreenState: LaunchScreenStateManager
    @State private var email = ""
    @State private var Username = ""
    @State private var password = ""
    @State private var Confirm = ""
    @State private var errorMessage = ""
    @Binding var userHasSignedUp: Bool
   
    var body: some View {
        NavigationView{
                ZStack {
                    Color.black
                    RoundedRectangle(cornerRadius: 30,style: .continuous)
                        .foregroundStyle(.linearGradient(colors: [.pink,.red], startPoint: .topLeading, endPoint: .bottomTrailing))
                        .frame(width: 1000,height: 400)
                        .rotationEffect(.degrees(135))
                    
                    VStack(spacing:20){
                        Group{
                        //
                        Text("SignUp")
                            .foregroundColor(.white)
                            .font(.system(size: 40,weight: .bold,design: .rounded))
                            .offset(x: -100,y:-100)
                        
                        //
                        TextField("Username",text: $Username)
                        
                            .foregroundColor(.white)
                            .textFieldStyle(.plain)
                            .Placeholder(when: Username.isEmpty){
                                Text("Username")
                                    .foregroundColor(.white)
                                    .bold()
                            }
                        Rectangle()
                            .frame(width: 350,height: 1)
                            .foregroundColor(.white)
                        
                        
                        //
                        TextField("Email",text: $email)
                            .foregroundColor(.white)
                            .textFieldStyle(.plain)
                            .Placeholder(when: email.isEmpty){
                                Text("Email")
                                    .foregroundColor(.white)
                                    .bold()
                            }
                        Rectangle()
                            .frame(width: 350,height: 1)
                            .foregroundColor(.white)
                        
                        //
                        SecureField("Password",text: $password)
                            .foregroundColor(.white)
                            .textFieldStyle(.plain)
                            .Placeholder(when: password.isEmpty) {
                                Text("Password")
                                    .foregroundColor(.white)
                                    .bold()
                            }
                        Rectangle()
                            .frame(width: 350,height: 1)
                            .foregroundColor(.white)
                        
                        
                        //
                        SecureField("Confrim Pass",text: $Confirm)
                            .foregroundColor(.white)
                            .textFieldStyle(.plain)
                            .placeholder(when: Confirm.isEmpty) {
                                Text("Confirm Password")
                                    .foregroundColor(.white)
                                    .bold()
                            }
                        Rectangle()
                            .frame(width: 350,height: 1)
                            .foregroundColor(.white)
                        
                        
                        Button{
                           
                            register()
                            
                        } label: {
                            Text("Signup")
                                .bold()
                                .frame(width: 200,height: 40)
                                .background(RoundedRectangle(cornerRadius: 10,style: .continuous)
                                    .fill(.linearGradient(colors: [.black], startPoint: .top, endPoint: .bottomTrailing))
                                )
                                .foregroundColor(.white)
                        }
                        .padding(.top)
                        .offset(y:50)
                        
                    }
                        
                        if !errorMessage.isEmpty{
                            Text(errorMessage)
                                .foregroundColor(.white)
                                .padding()
                                .offset(y:50)
                            
                        }
                    }
                    
                    .frame(width: 350)
                  
                   
            }
                .ignoresSafeArea()
        }
    }
    
    func saveuser() {
        guard let user = Auth.auth().currentUser else {
            print("User not authenticated.")
            return
        }
        
        let db = Firestore.firestore()
        let userDocRef = db.collection("Usersinfo").document(user.email!)
        
        
        
        let userData = User(name: Username, email: email)
        
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


    
    func register(){
        
        let error = validate()
        if let error = error{
            errorMessage = error
        }else{
            Auth.auth().createUser(withEmail: email, password: password) { result, error in
                
                if error != nil {
                    print(error!.localizedDescription)
                    errorMessage = error!.localizedDescription
                }
                else{
                    saveuser()
                    userHasSignedUp = true
                   
                }
            }
        }
        
    }
    func validate() -> String? {
          if email.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty || password.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty {
              return "Please fill all the fields!"
          }
        if Username.isEmpty{
            return "Please fill your name!"
        }
          if !Utilities.isValidEmailAddress(emailAddressString: email) {
              return "Email format is incorrect!"
          }
          if !Utilities.isPasswordValid(password) {
              return "Password too weak!"
          }
        if password != Confirm{
            return"Password Does not match"
        }
        

          return nil
      }
    
}

struct SignupView_Previews: PreviewProvider {
    static var previews: some View {
        SignupView(userHasSignedUp: .constant(false))
            .environmentObject(LaunchScreenStateManager())
    }
}
extension View {
    func Placeholder<Content: View>(
        when shouldShow: Bool,
        alignment: Alignment = .leading,
        @ViewBuilder placeholder: () -> Content) -> some View {

        ZStack(alignment: alignment) {
            placeholder().opacity(shouldShow ? 1 : 0)
            self
        }
    }
}
