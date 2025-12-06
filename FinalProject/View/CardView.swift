//
//  CardView.swift
//  FinalProject
//
//  Created by Kelvin Chao on 11/24/25.
//

/*
 * Kelvin Chao
 * CIS 137
 * Pacheco
 * Final Project
 * 11/24/25
 */

import SwiftUI


// Just displays the card information using the card value passed through
struct CardView: View {
    let card: Card
    
    var body: some View {
        ZStack{
            RoundedRectangle(cornerRadius: 10).fill(Color.white).frame(width: 80, height: 120).shadow(radius: 5)
            VStack{
                Text(card.suit).padding(.bottom, 10)
                Text(card.value == "1" ? "A" : card.value).fontWeight(.bold).font(.title).fontDesign(.rounded)
            }

        }
        
    }
}

#Preview {
    CardView(card: Card( value: "1", suit: "♠️"))
}
