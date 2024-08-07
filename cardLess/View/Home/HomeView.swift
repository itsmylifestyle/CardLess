//
//  HomeView.swift
//  cardLess
//
//  Created by Айбек on 30.07.2024.
//

import SwiftUI

struct HomeView: View {
    
    @EnvironmentObject var cardData: HomeViewModel
    
    var body: some View {
        NavigationView {
            ScrollView {
                VStack(spacing: 10) {
                    ForEach(cardData.cards, id: \.id) { card in
                        NavigationLink(destination: DetailedCardView(card: card)) {
                            CardView(card: card)
                                .background(Color.clear)
                                .padding(.vertical, 5)
                        }
                        .buttonStyle(PlainButtonStyle())
                    }
                }
                .background(.white)
            }
        }
    }
    
}

#Preview {
    HomeView()
        .environmentObject(HomeViewModel())
}
