//
//  CardView.swift
//  FinalProject
//
//  Created by Kelvin Chao on 11/24/25.
//

import SwiftUI


// Just displays the card information using the card value passed through
struct CardView: View {
    let card: Card
    
    var body: some View {
        ZStack{
            RoundedRectangle(cornerRadius: 10).fill(Color.white).frame(width: 80, height: 120).shadow(radius: 5)
            VStack{
                Text(card.suit)
                Text(card.value).fontWeight(.bold)
            }

        }
        
    }
}

#Preview {
    CardView(card: Card( value: "10", suit: "Spades"))
}
