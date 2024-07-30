//
//  MainView.swift
//  cardLess
//
//  Created by Айбек on 31.07.2024.
//

import SwiftUI
import Firebase

struct MainView: View {
    
    @State var index = 0
    @State var show = false
    @State private var isLoggedOut = false
    
    var body: some View {
        ZStack {
            HStack {
                VStack(alignment: .leading, spacing: 12) {
                    
                    Text("Card")
                        .font(.system(size: 50))
                        .fontWeight(.bold)
                        .foregroundColor(.white)
                        .padding(.top, 10)
                    
                    Text("Less")
                        .font(.title)
                        .fontWeight(.bold)
                        .foregroundColor(.red)
                    
                    Button(action: {
                        self.index = 0
                        withAnimation {
                            self.show.toggle()
                        }
                    }) {
                        HStack(spacing: 25) {
                            Image(systemName: "house")
                                .foregroundColor(self.index == 0 ? Color.white : Color.gray)
                            
                            Text("Home")
                                .foregroundColor(self.index == 0 ? Color.white : Color.gray)
                        }
                        .padding(.vertical, 10)
                        .padding(.horizontal)
                        .background(self.index == 0 ? Color.gray.opacity(0.2) : Color.clear)
                        .cornerRadius(10)
                    }
                    .padding(.top, 25)
                    
                    Button(action: {
                        self.index = 1
                        withAnimation {
                            self.show.toggle()
                        }
                    }) {
                        HStack(spacing: 25) {
                            Image(systemName: "plus.square.on.square")
                                .foregroundColor(self.index == 1 ? Color.white : Color.gray)
                            
                            Text("Add new card")
                                .foregroundColor(self.index == 1 ? Color.white : Color.gray)
                        }
                    }
                    .padding(.vertical, 10)
                    .padding(.horizontal)
                    .background(self.index == 1 ? Color.gray.opacity(0.2) : Color.clear)
                    .cornerRadius(10)
                    
                    Button(action: {
                        self.index = 2
                        withAnimation {
                            self.show.toggle()
                        }
                    }) {
                        HStack(spacing: 25) {
                            Image(systemName: "gear")
                                .foregroundColor(self.index == 2 ? Color.white : Color.gray)
                            
                            Text("Settings")
                                .foregroundColor(self.index == 2 ? Color.white : Color.gray)
                        }
                    }
                    .padding(.vertical, 10)
                    .padding(.horizontal)
                    .background(self.index == 2 ? Color.gray.opacity(0.2) : Color.clear)
                    .cornerRadius(10)
                    
                    
                    Divider()
                        .frame(width: 150, height: 1)
                        .background(Color.white)
                        .padding(.vertical, 30)
                    
                    Button(action: {
                        logout()
                    }) {
                        HStack {
                            Image(systemName: "arrow.uturn.backward")
                                .foregroundColor(.gray)
                            
                            Text("Logout")
                                .foregroundColor(.gray)
                        }
                        .padding(.vertical, 10)
                        .padding(.horizontal)
                    }
                    .navigationDestination(isPresented: $isLoggedOut) {
                        SignIn()
                    }
                    Spacer(minLength: 0)
                }
                .padding(.top, 25)
                .padding(.horizontal, 25)
                
                Spacer(minLength: 0)
            }
            .padding(.top, UIApplication.shared.windows.first?.safeAreaInsets.top)
            .padding(.top, UIApplication.shared.windows.first?.safeAreaInsets.bottom)
            
            VStack(spacing: 0) {
                HStack(spacing: 15) {
                    Button(action: {
                        withAnimation {
                            self.show.toggle()
                        }
                    }) {
                        Image(systemName: self.show ? "xmark" : "line.horizontal.3")
                            .resizable()
                            .frame(width: self.show ? 18 : 22, height: 18)
                            .foregroundColor(Color.black.opacity(0.4))
                    }
                    
                    Text(self.index == 0 ? "Home" : (self.index == 1 ? "Add new card" : "Settings"))
                        .font(.title)
                        .foregroundColor(.black.opacity(0.6))
                    
                    
                    Spacer(minLength: 0)
                }
                .padding(.top, UIApplication.shared.windows.first?.safeAreaInsets.top)
                .padding()
                
                GeometryReader { _ in
                    NavigationView {
                        VStack {
                            if self.index == 0 {
                                HomeView()
                                    .environmentObject(HomeViewModel())
                                    .offset(x: self.show ? UIScreen.main.bounds.width : 0)
                            }
                            else if self.index == 1 {
                                AddNewCardView()
                                    .environmentObject(HomeViewModel())
                                    .environmentObject(NewCardViewModel())
                            }
                            else {
                                // Implement content for Settings
                            }
                        }
                    }
                }
            }
            .background(Color.white)
            .cornerRadius(self.show ? 30 : 0)
            .scaleEffect(self.show ? 0.9 : 1)
            .offset(x: self.show ? UIScreen.main.bounds.width / 2 : 0, y: self.show ? 15 : 0)
            .rotationEffect(.init(degrees: self.show ? -5 : 0))
        }
        .navigationBarBackButtonHidden()
        .background(Color.black.edgesIgnoringSafeArea(.all))
        .edgesIgnoringSafeArea(.all)
    }
    
    
    func logout() {
        do {
            try Auth.auth().signOut()
            DispatchQueue.main.async {
                isLoggedOut = true
            }
        } catch let signOutError as NSError {
            print("Error signing out: %@", signOutError.localizedDescription)
        }
    }
}

#Preview {
    MainView()
}
