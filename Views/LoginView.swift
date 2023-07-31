//
//  ContentView.swift
//  Kaio
//
//  Created by Manraj Singh on 30/06/23.
//

import SwiftUI
import Firebase

struct LoginView: View {
    @EnvironmentObject private var launchScreenState: LaunchScreenStateManager
    @State private var isSignup = false
    @State private var email = ""
    @State private var password = ""
    @State private var remem = false
    @State private var errorMessage = ""
    @Binding var userIsLoggedIn: Bool
    @Binding var userHasSignedUp: Bool
    
    var body: some View{
        if Auth.auth().currentUser != nil{
            MainView()
        }else{
            content
        }
    }
    var content: some View {
        NavigationView{
            ZStack {
                Color.black
                RoundedRectangle(cornerRadius: 30,style: .continuous)
                    .foregroundStyle(.linearGradient(colors: [.pink,.red], startPoint: .topLeading, endPoint: .bottomTrailing))
                    .frame(width: 1000,height: 400)
                    .rotationEffect(.degrees(135))
                VStack(spacing:20){
                    Text("Welcome")
                        .foregroundColor(.white)
                        .font(.system(size: 40,weight: .bold,design: .rounded))
                        .offset(x: -100,y:-100)
                    TextField("Email",text: $email)
                        .foregroundColor(.white)
                        .textFieldStyle(.plain)
                        .placeholder(when: email.isEmpty){
                            Text("Email")
                                .foregroundColor(.white)
                                .bold()
                        }
                    Rectangle()
                        .frame(width: 350,height: 1)
                        .foregroundColor(.white)
                    SecureField("Password",text: $password)
                        .foregroundColor(.white)
                        .textFieldStyle(.plain)
                        .placeholder(when: password.isEmpty) {
                            Text("Password")
                                .foregroundColor(.white)
                                .bold()
                        }
                    Rectangle()
                        .frame(width: 350,height: 1)
                        .foregroundColor(.white)
              //      Toggle("Remember me",isOn: $remem)
                        .foregroundColor(Color(hue: 0.83, saturation: 0.0, brightness: 0.0))
                 //   if remem{
                   //     let _ = print("Toggle is working!")
                   // }
                    Group{
                        if remem{
                              let _ = print("Toggle is working!")
                          }
                        if !errorMessage.isEmpty{
                            Text(errorMessage)
                            
                        }
                    }
                   
                    Button{
                        login()
                                                
                    } label: {
                        Text("Login")
                            .bold()
                            .frame(width: 200,height: 40)
                            .background(RoundedRectangle(cornerRadius: 10,style: .continuous)
                                .fill(.linearGradient(colors: [.black], startPoint: .top, endPoint: .bottomTrailing))
                            )
                            .foregroundColor(.white)
                    }
                    .padding(.top)
                    .offset(y:50)
                   
                    
                    //
                   

                    //
                    Button {
                        
                        forgot()
                    } label: {
                        Text("Forgot Password?")
                            .bold()
                            .foregroundColor(.white)
                    }
                    .padding(.top)
                    .offset(y:50)
                    
                    NavigationLink(destination: {
                        SignupView(userHasSignedUp: $userHasSignedUp)
                    }, label: {
                        Text("Do not have an account? Signup")
                            .bold()
                            .foregroundColor(.white)
                    })
                    .padding(.top)
                    .offset(y:50)
                    
            
                   
                    
                }
                .frame(width: 350)
                .onAppear{
                    
                    Auth.auth().addStateDidChangeListener { auth, user in
                        if user != nil{
                            userIsLoggedIn.toggle()
                        }
                    }
                }
            }
            .ignoresSafeArea()
        }
       
    }
    
    
    
    func login(){
        let error = validate()
        if let error = error{
            errorMessage = error
        }
        else{
            Auth.auth().signIn(withEmail: email, password: password) { result , error in
                if error != nil {
                    print(error!.localizedDescription)
                    errorMessage = error!.localizedDescription
                }
                else{
                    userIsLoggedIn = true
                }
            }
        }
    }
    func forgot(){
        let error = validateForEmail()
        if let error = error{
            errorMessage = error
        }
        else{
            Auth.auth().sendPasswordReset(withEmail: email) { error in
                if error != nil{
                    print(error!.localizedDescription)
                    errorMessage = error!.localizedDescription
                }
                
            }
        }
    }
    func validateForEmail()-> String?{
        if email.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty{
            return "Please Enter the Email!"
        }
        return nil
    }
    func validate() -> String? {
          if email.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty || password.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty {
              return "Please fill all the fields!"
          }
          if !Utilities.isValidEmailAddress(emailAddressString: email) {
              return "Email format is incorrect!"
          }
          if !Utilities.isPasswordValid(password) {
              return "Incorrect Password!"
          }

          return nil
      }
    
}




    struct LoginView_Previews: PreviewProvider {
        static var previews: some View {
            LoginView(userIsLoggedIn: .constant(false), userHasSignedUp: .constant(false))
                .environmentObject(LaunchScreenStateManager())
        }
    }

extension View {
    func placeholder<Content: View>(
        when shouldShow: Bool,
        alignment: Alignment = .leading,
        @ViewBuilder placeholder: () -> Content) -> some View {

        ZStack(alignment: alignment) {
            placeholder().opacity(shouldShow ? 1 : 0)
            self
        }
    }
}
