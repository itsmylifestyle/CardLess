//
//  NewCardViewModel.swift
//  cardLess
//
//  Created by Айбек on 31.07.2024.
//
import Foundation
import SwiftUI
import Firebase

class NewCardViewModel: ObservableObject {
    @Published var cards: [Card] = []
    
    func addNewCard(cardNumber: String, nameSurename: String, orgName: String, dueDate: String, cvv: String, email: String, phone: String, optional: String) {
        let db = Firestore.firestore()
        
        let cardID = UUID().uuidString
        
        let cardData: [String: Any] = [
            "cardNumber": cardNumber,
            "nameSurname": nameSurename,
            "orgName": orgName,
            "dueDate": dueDate,
            "cvv": cvv,
            "email": email,
            "phone": phone,
            "optional": optional
        ]
        
        db.collection("Cards").document(cardID).setData(cardData) { error in
            if let error = error {
                print("Error adding card: \(error.localizedDescription)")
            } else {
                print("Card added successfully!")
            }
        }
    }
}


