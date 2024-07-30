//
//  ContentView.swift
//  cardLess
//
//  Created by Айбек on 30.07.2024.
//

import SwiftUI
import Firebase

struct SignIn: View {
    
    @State var email = ""
    @State var pass = ""
    @State private var showAlert = false
    @State private var alertMessage = ""
    @State private var navigateToHome = false
    
    let fbManager = Manager()
    
    var body: some View {
        VStack {
            
            VStack(alignment: .leading) {
                Text("Welcome back")
                    .foregroundStyle(.white)
                    .fontWeight(.bold)
                    .font(.headline)
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(.bottom, 5)
            .padding(.top, 30)
            
            VStack(alignment: .leading) {
                Text("please sign in to your account")
                    .foregroundStyle(.gray.opacity(0.7))
                    .fontWeight(.light)
                    .font(.subheadline)
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(.bottom, 20)
            
            VStack{
                VStack(alignment: .leading) {
                    Text("Email")
                        .foregroundStyle(.white)
                        .font(.footnote)
                        .fontWeight(.semibold)
                        .padding(.bottom, 0)
                    
                    TextField("Email", text: $email)
                        .padding(15)
                        .background(Color.gray.opacity(0.2))
                        .cornerRadius(7)
                }
                .foregroundColor(.white)
                
                
                VStack(alignment: .leading) {
                    Text("Password")
                        .foregroundStyle(.white)
                        .font(.footnote)
                        .fontWeight(.semibold)
                        .padding(.bottom, 0)
                    
                    SecureField("Password", text: $pass)
                        .padding(15)
                        .background(Color.gray.opacity(0.2))
                        .cornerRadius(7)
                }
                .padding(.top, 30)
                .foregroundColor(.white)
            }
            
            VStack(alignment: .trailing) {
                Button(action: {
                    //
                }) {
                    Text("Forget password?")
                        .padding(.vertical, 6)
                        .frame(maxWidth: .infinity, alignment: .trailing)
                        .foregroundColor(.white)
                        .fontWeight(.regular)
                        .font(.footnote)
                }
            }
            
            VStack {
                HStack {
                    Rectangle()
                        .fill(Color.white.opacity(0.2))
                        .frame(height: 1)
                    
                    Text("OR")
                        .foregroundColor(.white)
                        .fontWeight(.medium)
                        .font(.callout)
                    
                    Rectangle()
                        .fill(Color.white.opacity(0.2))
                        .frame(height: 1)
                }
            }
            .padding(.vertical, 20)
            
            VStack {
                HStack {
                    Text("Don't have an account?")
                        .foregroundStyle(.white)
                        .font(.footnote)
                        .fontWeight(.regular)
                        .padding(.bottom, 0)
                    
                    
                    NavigationLink(destination: SignUp()) {
                        Text("Sign Up")
                            .foregroundColor(.white)
                            .font(.footnote)
                            .fontWeight(.bold)
                            .italic()
                    }
                }
                
            }
            
            
            Spacer()
            
            
            VStack {
                Button(action: {
                    fbManager.isUserRegistered(user: UserData(email: email, pass: pass)) { error in
                        if let error = error {
                            alertMessage = error.localizedDescription
                            showAlert = true
                        }
                    }
                }) {
                    Text("Sign In")
                        .padding(15)
                        .frame(maxWidth: .infinity)
                        .background(Color.white)
                        .foregroundColor(.black)
                        .font(.headline)
                        .fontWeight(.bold)
                        .cornerRadius(7)
                }
                
                NavigationLink(destination: HomeView(), isActive: $navigateToHome) {
                    EmptyView()
                }
            }
            
        }
        .padding(.horizontal)
        .padding()
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color.black)
        .alert(isPresented: $showAlert) {
            Alert(title: Text("Error"), message: Text(alertMessage), dismissButton: .default(Text("OK")))
        }
        .navigationBarBackButtonHidden(true)
    }
}

#Preview {
    SignIn()
}
