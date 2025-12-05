//
//  EndView.swift
//  FinalProject
//
//  Created by Kelvin Chao on 12/3/25.
//

import SwiftUI

struct EndView: View {
    var playerName: String = "Player"
    
    var body: some View {
        ZStack {
            Color.green.edgesIgnoringSafeArea(.all)
            VStack {
                HStack {
                    Text("♠️").font(.system(size: 80)).padding().rotationEffect(Angle(degrees: -30))
                    Spacer()
                    Text("❤️").font(.system(size: 80)).padding().rotationEffect(Angle(degrees: 30))
                }.padding()
                Spacer()
                Text("Game Over").foregroundColor(Color.white).font(.system(size: 64)).fontDesign(.serif).padding()
                Text("Thanks for playing \(playerName)!").foregroundColor(Color.white).font(.title)
                Spacer()
                HStack {
                    Text("♦️").font(.system(size: 80)).padding().rotationEffect(Angle(degrees: 210))
                    Spacer()
                    Text("♣️").font(.system(size: 80)).padding().rotationEffect(Angle(degrees: 150))
                }.padding()
            }
        }

    }
}

#Preview {
    EndView()
}
