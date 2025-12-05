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
                Text("Game Over").foregroundColor(Color.white).font(.largeTitle).padding()
                Text("Thanks for playing \(playerName)!").foregroundColor(Color.white).font(.title)
            }
        }

    }
}

#Preview {
    EndView()
}
