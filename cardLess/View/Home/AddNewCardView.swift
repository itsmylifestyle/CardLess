//
//  AddNewCardView.swift
//  cardLess
//
//  Created by Айбек on 31.07.2024.
//

import SwiftUI

struct AddNewCardView: View {
    @EnvironmentObject var cardData: HomeViewModel
    @EnvironmentObject var addData: NewCardViewModel
    @Environment(\.presentationMode) var presentationMode
    
    @State private var cardNumber = ""
    @State private var nameSurename = ""
    @State private var orgName = ""
    @State private var dueDate = ""
    @State private var cvv = ""
    @State private var email = ""
    @State private var phone = ""
    @State private var optional = ""
    
    @State private var isSaved = false
    
    var body: some View {
        NavigationStack {
            VStack {
                ScrollView {
                    VStack {
                        VStack(alignment: .leading, spacing: 10) {
                            
                            Text(orgName)
                                .font(.custom("Arial", size: 30))
                                .fontWeight(.semibold)
                                .padding(.horizontal)
                                .padding(.top, 25)
                            
                            Text(nameSurename)
                                .font(.custom("Arial", size: 16))
                                .fontWeight(.regular)
                                .padding(.bottom, 20)
                                .padding(.horizontal)
                            
                            
                            Text(cardNumber)
                                .font(.system(.title2, design: .monospaced))
                                .fontWeight(.bold)
                                .padding(.horizontal)
                            
                            
                            VStack {
                                Text(dueDate)
                                    .italic()
                                    .font(.caption)
                                    .padding(.top, 20)
                                    .padding(.horizontal)
                                    .padding(.bottom, 20)
                            }
                            .frame(maxWidth: .infinity, alignment: .trailing)
                        }
                        .frame(height: 200)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .cornerRadius(20)
                        .padding(20)
                    }
                    .frame(height: 200)
                    .background(RoundedRectangle(cornerRadius: 20)
                        .fill(Color.white)
                        .shadow(radius: 5))
                    .padding(.bottom, 50)
                    .padding(.top, 20)
                    .padding(.horizontal, 40)
                    
                    
                    VStack(alignment: .leading) {
                        Text("Enter card numbers")
                            .foregroundStyle(.black)
                            .font(.footnote)
                            .fontWeight(.semibold)
                            .padding(.bottom, 0)
                        
                        TextField("0000 0000 0000 0000", text: $cardNumber)
                            .padding(15)
                            .background(Color.gray.opacity(0.2))
                            .cornerRadius(7)
                    }
                    .foregroundColor(.black)
                    .padding(.horizontal, 40)
                    
                    VStack(alignment: .leading) {
                        Text("Enter cardholder name and surname")
                            .foregroundStyle(.black)
                            .font(.footnote)
                            .fontWeight(.semibold)
                            .padding(.bottom, 0)
                        
                        TextField("Name and Surname", text: $nameSurename)
                            .padding(15)
                            .background(Color.gray.opacity(0.2))
                            .cornerRadius(7)
                    }
                    .padding(.top, 25)
                    .foregroundColor(.black)
                    .padding(.horizontal, 40)
                    
                    VStack(alignment: .leading) {
                        Text("Enter organization name")
                            .foregroundStyle(.black)
                            .font(.footnote)
                            .fontWeight(.semibold)
                            .padding(.bottom, 0)
                        
                        TextField("Magnum", text: $orgName)
                            .padding(15)
                            .background(Color.gray.opacity(0.2))
                            .cornerRadius(7)
                    }
                    .padding(.top, 25)
                    .foregroundColor(.black)
                    .padding(.horizontal, 40)
                    
                    VStack(alignment: .leading) {
                        Text("Expiration date")
                            .foregroundStyle(.black)
                            .font(.footnote)
                            .fontWeight(.semibold)
                            .padding(.bottom, 0)
                        
                        TextField("13 March 2099", text: $dueDate)
                            .padding(15)
                            .background(Color.gray.opacity(0.2))
                            .cornerRadius(7)
                    }
                    .padding(.top, 25)
                    .foregroundColor(.black)
                    .padding(.horizontal, 40)
                    
                    VStack(alignment: .leading) {
                        Text("Enter CVV code")
                            .foregroundStyle(.black)
                            .font(.footnote)
                            .fontWeight(.semibold)
                            .padding(.bottom, 0)
                        
                        TextField("CVV", text: $cvv)
                            .padding(15)
                            .background(Color.gray.opacity(0.2))
                            .cornerRadius(7)
                    }
                    .padding(.top, 25)
                    .foregroundColor(.black)
                    .padding(.horizontal, 40)
                    
                    VStack(alignment: .leading) {
                        Text("Enter linked email")
                            .foregroundStyle(.black)
                            .font(.footnote)
                            .fontWeight(.semibold)
                            .padding(.bottom, 0)
                        
                        TextField("Email", text: $email)
                            .padding(15)
                            .background(Color.gray.opacity(0.2))
                            .cornerRadius(7)
                    }
                    .padding(.top, 25)
                    .foregroundColor(.black)
                    .padding(.horizontal, 40)
                    
                    VStack(alignment: .leading) {
                        Text("Enter linked phone number")
                            .foregroundStyle(.black)
                            .font(.footnote)
                            .fontWeight(.semibold)
                            .padding(.bottom, 0)
                        
                        TextField("+7 (777) 777 77 77", text: $phone)
                            .padding(15)
                            .background(Color.gray.opacity(0.2))
                            .cornerRadius(7)
                    }
                    .padding(.top, 25)
                    .foregroundColor(.black)
                    .padding(.horizontal, 40)
                    
                    VStack(alignment: .leading) {
                        Text("Enter additional information")
                            .foregroundStyle(.black)
                            .font(.footnote)
                            .fontWeight(.semibold)
                            .padding(.bottom, 0)
                        
                        TextField("Info.", text: $optional)
                            .padding(15)
                            .background(Color.gray.opacity(0.2))
                            .cornerRadius(7)
                    }
                    .padding(.top, 25)
                    .foregroundColor(.black)
                    .padding(.horizontal, 40)
                    
                    VStack {
                        Button(action: {
                            addData.addNewCard(cardNumber: cardNumber, nameSurename: nameSurename, orgName: orgName, dueDate: dueDate, cvv: cvv, email: email, phone: phone, optional: optional)
                            isSaved = true
                        }) {
                            Text("Save")
                                .padding(15)
                                .frame(maxWidth: .infinity)
                                .background(Color.black)
                                .foregroundColor(.white)
                                .font(.headline)
                                .fontWeight(.bold)
                                .cornerRadius(7)
                        }
                    }
                    .padding(.top, 25)
                    .padding(.horizontal, 40)
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .navigationBarBackButtonHidden(true)
            }
            .background(Color.white)
        }
        .navigationDestination(isPresented: $isSaved) {
            MainView()
        }
    }
}



#Preview {
    AddNewCardView()
        .environmentObject(HomeViewModel())
        .environmentObject(NewCardViewModel())
}
