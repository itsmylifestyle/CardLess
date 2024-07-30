//
//  Card.swift
//  cardLess
//
//  Created by Айбек on 31.07.2024.
//

import Foundation

struct Card: Identifiable {
    var id: UUID
    var cardNumber: String
    var nameSurename: String
    var orgName: String
    var dueDate: String
    var cvv: String
    
    var email: String
    var phone: String
    var optional: String
}
