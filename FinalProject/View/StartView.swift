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
                Text("Poker Game").navigationTitle(Text("Poker Game"))
                    .font(.system(size: 42, weight: .bold))
                    .foregroundColor(.white)
                    .padding()
                
                
                TextField("Enter player name", text: $textInput).padding(10).background(Color.white).cornerRadius(10).padding()
                
                
                NavigationLink(destination: GameView(playerName: textInput)) {
                    Text("Start Game")
                }.disabled(textInput.isEmpty)
                
            }
        }.navigationTitle("")
    }
}

#Preview {
    StartView()
}
