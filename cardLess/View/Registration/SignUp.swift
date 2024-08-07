//
//  SignUp.swift
//  cardLess
//
//  Created by Айбек on 30.07.2024.
//

import SwiftUI
import Firebase

struct SignUp: View {
    
    @State var email = ""
    @State var pass = ""
    @State private var showAlert = false
    @State private var alertMessage = ""
    @State private var navigateToSignIn = false
    
    @State private var isPasswordLengthValid = false
    @State private var isPasswordContainsLetter = false
    
    let fbManager = Manager()
    
    var body: some View {
        NavigationStack {
            VStack {
                VStack(alignment: .leading) {
                    Text("Glad to have you with us at CardLess!")
                        .foregroundColor(.white)
                        .fontWeight(.medium)
                        .font(.largeTitle)
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.bottom, 5)
                .padding(.top, 30)
                
                VStack(alignment: .leading) {
                    Text("Complete the required fields with your information.")
                        .foregroundColor(.gray.opacity(0.7))
                        .fontWeight(.light)
                        .font(.subheadline)
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.bottom, 20)
                
                VStack {
                    VStack(alignment: .leading) {
                        Text("Email")
                            .foregroundColor(.white)
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
                            .foregroundColor(.white)
                            .font(.footnote)
                            .fontWeight(.semibold)
                            .padding(.bottom, 0)
                        
                        SecureField("Password", text: $pass)
                            .padding(15)
                            .background(Color.gray.opacity(0.2))
                            .cornerRadius(7)
                            .onChange(of: pass) { newValue in
                                validatePassword(newValue)
                            }
                        
                        VStack(alignment: .leading) {
                            HStack {
                                if isPasswordLengthValid {
                                    Image(systemName: "checkmark.circle.fill")
                                        .foregroundColor(.white)
                                } else {
                                    Image(systemName: "checkmark.circle")
                                        .foregroundColor(.black)
                                        .overlay(
                                            Circle().stroke(Color.white, lineWidth: 1)
                                        )
                                }
                                Text("Password must be at least 6 characters")
                                    .foregroundColor(.gray)
                                    .font(.footnote)
                            }
                            .padding(.top, 5)
                            
                            HStack {
                                if isPasswordContainsLetter {
                                    Image(systemName: "checkmark.circle.fill")
                                        .foregroundColor(.white)
                                } else {
                                    Image(systemName: "checkmark.circle")
                                        .foregroundColor(.black)
                                        .overlay(
                                            Circle().stroke(Color.white, lineWidth: 1)
                                        )
                                }
                                Text("Password must contain at least one letter")
                                    .foregroundColor(.gray)
                                    .font(.footnote)
                            }
                            .padding(.top, 5)
                        }
                        .padding(.top, 5)
                    }
                    .padding(.top, 30)
                    .foregroundColor(.white)
                    
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
                        Text("Already have an account?")
                            .foregroundColor(.white)
                            .font(.footnote)
                            .fontWeight(.regular)
                            .padding(.bottom, 0)
                        
                        NavigationLink(destination: SignIn()) {
                            Text("Sign In")
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
                        UIApplication.shared.endEditing()
                        
                        fbManager.registerNewUser(user: UserData(email: email, pass: pass)) { error in
                            if let error = error {
                                alertMessage = error.localizedDescription
                                showAlert = false
                                navigateToSignIn = true
                            } else {
                                DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                                    navigateToSignIn = true
                                }
                            }
                        }
                    }) {
                        Text("Sign Up")
                            .padding(15)
                            .frame(maxWidth: .infinity)
                            .background(Color.white)
                            .foregroundColor(.black)
                            .font(.headline)
                            .fontWeight(.bold)
                            .cornerRadius(7)
                    }
                }
                .navigationDestination(isPresented: $navigateToSignIn) {
                    SignIn()
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
        .navigationDestination(isPresented: $navigateToSignIn) {
            SignIn()
        }
    }
    
    func validatePassword(_ password: String) {
        isPasswordLengthValid = password.count >= 6
        let letterRegex = ".*[A-Za-z]+.*"
        isPasswordContainsLetter = NSPredicate(format: "SELF MATCHES %@", letterRegex).evaluate(with: password)
    }
}

#Preview {
    SignUp()
}

extension UIApplication {
    func endEditing() {
        sendAction(#selector(UIApplication.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}
