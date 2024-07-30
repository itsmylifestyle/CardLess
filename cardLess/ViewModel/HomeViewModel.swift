//
//  HomeViewModel.swift
//  cardLess
//
//  Created by Айбек on 31.07.2024.
//

import Foundation
import SwiftUI
import Firebase

class HomeViewModel: ObservableObject {
    @Published var cards: [Card] = []
    
    init() {
        fetchCards()
    }
    
    func fetchCards() {
        cards.removeAll()
        let db = Firestore.firestore()
        let reference = db.collection("Cards")
        reference.getDocuments { snapshot, error in
            guard error == nil else {
                print(error!.localizedDescription)
                return
            }
            
            if let snapshot = snapshot {
                for document in snapshot.documents {
                    let data = document.data()
                    
                    let idString = document.documentID
                    let id = UUID(uuidString: idString) ?? UUID()
                    
                    let cardNumber = data["cardNumber"] as? String ?? ""
                    let nameSurename = data["nameSurname"] as? String ?? ""
                    let orgName = data["orgName"] as? String ?? ""
                    let dueDate = data["dueDate"] as? String ?? ""
                    let cvv = data["cvv"] as? String ?? ""
                    
                    let email = data["email"] as? String ?? ""
                    let phone = data["phone"] as? String ?? ""
                    let optional = data["optional"] as? String ?? ""
                    
                    let card = Card(id: id, cardNumber: cardNumber, nameSurename: nameSurename, orgName: orgName, dueDate: dueDate, cvv: cvv, email: email, phone: phone, optional: optional)
                    
                    self.cards.append(card)
                }
            }
        }
    }
}

