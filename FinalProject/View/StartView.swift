//
//  StartView.swift
//  FinalProject
//
//  Created by Kelvin Chao on 12/3/25.
//

import SwiftUI

struct StartView: View {

    @State var textInput: String = ""
    
    var body: some View {
        ZStack {
            Color.green.ignoresSafeArea(edges: .all)

            VStack {
                HStack {
                    Text("♠️").font(.system(size: 80)).padding()
                    Spacer()
                    Text("❤️").font(.system(size: 80)).padding()
                }.padding()
                Spacer()
                Text("Black Jack")
                    .font(.system(size: 54, weight: .bold))
                    .foregroundColor(.white)
                    .fontDesign(.serif)
                    .padding()
                
                
                TextField("Enter player name", text: $textInput).padding(10).background(Color.white).cornerRadius(10).padding(.horizontal, 100)
                
                
                NavigationLink(destination: GameView(playerName: textInput)) {
                    Text("Start Game")
                }.disabled(textInput.isEmpty)
                Spacer()
                HStack {
                    Text("♦️").font(.system(size: 80)).padding()
                    Spacer()
                    Text("♣️").font(.system(size: 80)).padding()
                }.padding()
            }
        }.navigationTitle("")
    }
}

#Preview {
    StartView()
}
