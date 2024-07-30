//
//  DetailedCardView.swift
//  cardLess
//
//  Created by Айбек on 31.07.2024.
//

import SwiftUI

struct DetailedCardView: View {
    var card: Card
    
    @State var show = false
    @State var viewState = CGSize.zero
    @State var showBotCard = false
    @State var bottomState = CGSize.zero
    @State var showFull = false
    
    
    var body: some View {
        ZStack() {
            titleView()
                .blur(radius: show ? 20 : 0)
                .opacity(show ? 0 : 1)
                .opacity(showBotCard ? 0.4 : 1)
                .offset(y: showBotCard ? -200 : 0)
                .frame(maxHeight: .infinity, alignment: .top)
                .animation(
                    Animation.default.delay(0.1)
                )
            
            backCardView()
                .frame(width: showBotCard ? 300 : 340, height: 220)
                .background(show ? Color.red : Color.blue)
                .cornerRadius(20)
                .shadow(radius: 20)
                .offset(x: 0, y: show ? 150 : -40)
                .offset(y: showBotCard ? -180 : 0)
                .offset(x: viewState.width, y: viewState.height)
                .scaleEffect(showBotCard ? 1 : 0.9)
                .rotationEffect(.degrees(show ? 0 : 10))
                .rotationEffect(.degrees(showBotCard ? -10 : 0))
                .rotation3DEffect(
                    .degrees(showBotCard ? 0 : 10),
                    axis: (x: 10.0, y: 5.0, z: 0.0)
                )
                .blendMode(.hardLight)
                .animation(.bouncy(duration: 0.6))
            
            backCardView()
                .frame(width: 340, height: 220)
                .background(show ? Color.blue : Color.red)
                .cornerRadius(20)
                .shadow(radius: 20)
                .offset(x: 0, y: show ? -170 : -20)
                .offset(y: showBotCard ? -140 : 0)
                .offset(x: viewState.width, y: viewState.height)
                .scaleEffect(showBotCard ? 1 : 0.95)
                .rotationEffect(.degrees(show ? 0 : 5))
                .rotationEffect(.degrees(showBotCard ? -5 : 0))
                .rotation3DEffect(
                    .degrees(showBotCard ? 0 : 5),
                    axis: (x: 10.0, y: 0.0, z: 0.0)
                )
                .blendMode(.hardLight)
                .animation(.bouncy(duration: 0.3))
            
            detailedCard(card: card)
                .frame(width: showBotCard ? 375 : 340, height: 220)
                .background(Color.black)
                .clipShape(RoundedRectangle(cornerRadius: showBotCard ? 30 : 20, style: .continuous))
                .shadow(radius: 20)
                .offset(x: viewState.width, y: viewState.height)
                .offset(y: showBotCard ? -100 : 0)
                .blendMode(.hardLight)
                .animation(.spring(response: 0.3, dampingFraction: 0.6, blendDuration: 0))
                .onTapGesture {
                    self.showBotCard.toggle()
                }
                .gesture(
                    DragGesture()
                        .onChanged { value in
                            self.viewState = value.translation
                            self.show = true
                        }
                        .onEnded { value in
                            self.viewState = .zero
                            self.show = false
                        }
                )
            
//            Text("\(bottomState.height)").offset(y: -300)
            
            bottomCard(card: card)
                .offset(x: 0, y: showBotCard ? 360 : 1000)
                .offset(y: bottomState.height)
                .blur(radius: show ? 20 : 0)
                .animation(.timingCurve(0.2, 0.8, 0.2, 1, duration: 0.8))
                .gesture(
                    DragGesture()
                        .onChanged { value in
                            self.bottomState = value.translation
                            if self.showFull == true {
                                self.bottomState.height += -300
                            }
                            if self.bottomState.height < -300 {
                                self.bottomState.height = -300
                            }
                            
                        }
                        .onEnded { value in
                            if self.bottomState.height > 50 {
                                self.showBotCard = false
                            }
                            
                            if (self.bottomState.height < -100 && !self.showFull) || (self.bottomState.height < -250 && self.showFull) {
                                self.bottomState.height = -300
                                self.showFull = true
                            } else {
                                self.bottomState = .zero
                                self.showFull = false
                            }
                        }
                )
        }
    }
}

//MARK: - Helpers

struct detailedCard: View {
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
    }
    
    
    
    
    func formatCardNumber(_ number: Int) -> String {
        let numberString = String(number)
        let formattedString = numberString.enumerated().map { index, character in
            return (index % 4 == 0 && index != 0) ? " \(character)" : "\(character)"
        }.joined()
        return formattedString
    }
}

struct backCardView: View {
    var body: some View {
        VStack {
            Spacer()
        }
    }
}

struct titleView: View {
    var body: some View {
        VStack {
            HStack {
                Text("Detailed information")
                    .font(.title)
                    .fontWeight(.bold)
                
                Spacer()
            }
            .padding([.leading, .trailing], 20)
        }
    }
}

import SwiftUI

struct bottomCard: View {
    var card: Card

    var body: some View {
        VStack() {
            Rectangle()
                .frame(width: 40, height: 5)
                .cornerRadius(3)
                .opacity(0.1)
                .padding(.top, 5)
            
            VStack(alignment: .leading, spacing: 5) {
                detailRow(title: "Card Number:", value: card.cardNumber)
                separator
            }
            
            VStack(alignment: .leading, spacing: 5) {
                detailRow(title: "Name:", value: card.nameSurename)
                separator
            }
            
            VStack(alignment: .leading, spacing: 5) {
                detailRow(title: "Organization:", value: card.orgName)
                separator
            }
            
            VStack(alignment: .leading, spacing: 5) {
                detailRow(title: "Due Date:", value: card.dueDate)
                separator
            }
            
            VStack(alignment: .leading, spacing: 5) {
                detailRow(title: "CVV:", value: card.cvv)
                separator
            }
            
            VStack(alignment: .leading, spacing: 5) {
                detailRow(title: "Email:", value: card.email)
                separator
            }
            
            VStack(alignment: .leading, spacing: 5) {
                detailRow(title: "Phone:", value: card.phone)
                separator
            }
            
            VStack(alignment: .leading, spacing: 5) {
                detailRow(title: "Optional Info:", value: card.optional)
                separatorWhite
            }
            
            Spacer()
        }
        .padding(.top, 20)
        .padding(.horizontal, 20)
        .frame(maxWidth: .infinity)
        .background(Color("Background 3"))
        .cornerRadius(20)
        .shadow(radius: 20)
    }
    
    func formatCardNumber(_ number: Int) -> String {
        let numberString = String(number)
        let formattedString = numberString.enumerated().map { index, character in
            return (index % 4 == 0 && index != 0) ? " \(character)" : "\(character)"
        }.joined()
        return formattedString
    }
    
    private var separator: some View {
        Rectangle()
            .fill(Color(.lightGray))
            .frame(height: 1)
            .padding(.vertical, 5)
    }
    private var separatorWhite: some View {
        Rectangle()
            .fill(Color(.white))
            .frame(height: 1)
            .padding(.vertical, 5)
    }
    
    @ViewBuilder
    private func detailRow(title: String, value: String) -> some View {
        VStack(alignment: .leading, spacing: 5) {
            Text(title)
                .font(.title3)
                .fontWeight(.bold)
                .foregroundColor(.black)
            
            Text(value)
                .font(.subheadline)
                .fontWeight(.regular)
                .foregroundColor(.gray)
        }
    }
}



#Preview {
    HomeView()
        .environmentObject(HomeViewModel())
}
