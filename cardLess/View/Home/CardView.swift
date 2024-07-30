//
//  CardView.swift
//  cardLess
//
//  Created by Айбек on 31.07.2024.
//

import SwiftUI

import SwiftUI

struct CardView: View {
    var card: Card
    
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            
            Text(card.orgName)
                .font(.custom("Arial", size: 30))
                .fontWeight(.semibold)
                .padding(.horizontal)
                .padding(.top, 20)
            
            Text(card.nameSurename)
                .font(.custom("Arial", size: 16))
                .fontWeight(.regular)
                .padding(.bottom, 20)
                .padding(.horizontal)

            
            Text(card.cardNumber)
                .font(.system(.title2, design: .monospaced))
                .fontWeight(.bold)
                .padding(.horizontal)

            
            VStack {
                Text("\(card.dueDate)")
                    .italic()
                    .font(.caption)
                    .padding(.top, 20)
                    .padding(.horizontal)
                    .padding(.bottom, 20)
            }
            .frame(maxWidth: .infinity, alignment: .trailing)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .leading)
        .cornerRadius(20)
        .background(RoundedRectangle(cornerRadius: 20)
        .fill(Color.white)
        .shadow(radius: 5))
        .padding(20)
    }
    
    
    
    
    func formatCardNumber(_ number: Int) -> String {
        let numberString = String(number)
        let formattedString = numberString.enumerated().map { index, character in
            return (index % 4 == 0 && index != 0) ? " \(character)" : "\(character)"
        }.joined()
        return formattedString
    }
}
