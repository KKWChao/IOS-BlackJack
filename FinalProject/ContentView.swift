//
//  ContentView.swift
//  FinalProject
//
//  Created by Kelvin Chao on 11/24/25.
//

/*
 * Kelvin Chao
 * CIS 137
 * Pacheco
 * Homework 15
 * 11/24/25
 */

import SwiftUI

struct ContentView: View {
    @StateObject private var game = GameViewModel()
    
    @State private var pot = 0;
    @State private var potScale = 1.0
    @State private var bg = Color.green;
    

    
    var body: some View {
        VStack {
            HStack {
                Text("Final Project")
                    .font(.largeTitle)
                    .bold()
                    
                Spacer()
                
                Button(action: {}) {
                    Text("Theme")
                }.padding().contextMenu {
                    Button("Green") {
                        bg = Color.green
                    }
                    Button("Red") {
                        bg = Color.red
                    }
                    Button("Blue") {
                        bg = Color.blue
                    }
                }
            }

            ZStack {
                RoundedRectangle(cornerRadius: 10).fill(bg).shadow(radius: 5)
                VStack {
                    Spacer()
                    HStack() {
                        RoundedRectangle(cornerRadius: 10).fill(Color.gray).frame(width: 80, height: 120).padding()
                        CardView(card: Card(value: game.dealer.hand[1].value, suit: game.dealer.hand[1].suit))
                        
                    }
                    Spacer()
                    
                    ZStack {
                        Circle().fill(Color.white).frame(width: 100)

                        Text("\(pot)").fontWeight(.bold).foregroundColor(.blue).font(.title).scaleEffect(potScale)
                    }
                    Spacer()
                    HStack {
                        CardView(card: Card(value: game.mainPlayer.hand[0].value, suit: game.mainPlayer.hand[0].suit))
                        CardView(card: Card(value: game.mainPlayer.hand[1].value, suit: game.mainPlayer.hand[1].suit))
                        
                    }
                    Spacer()
                }
            
            }
            HStack {
                if(self.pot >= 15) {
                    Image(systemName: "exclamationmark.triangle").resizable().frame(width: 50, height: 50).foregroundColor(.red)
                }

                ZStack {
                    RoundedRectangle(cornerRadius: 10).frame(width: 150, height: 50).foregroundColor(.gray).padding().shadow(radius: 10)
                    
                    Text("Bet?")
                        .frame(width: 150, height: 30)
                        .font(.title)
                        .foregroundColor(.white).contextMenu {
                            Button(action: {
                                self.pot += 5
                                self.potScale += 0.2
                            }) {
                                Text("Add")
                                Image(systemName: "plus")
                            }
                            Button(action: {
                                self.pot -= 5
                                self.potScale -= 0.2
                            }) {
                                Text("Subtract")
                                Image(systemName: "minus")
                            }
                            Button(action: {
                                self.pot = 0
                                self.potScale = 1
                            }) {
                                Text("Reset")
                                Image(systemName: "eraser")
                            }
                        }
                    
                }
                
                ZStack {
                    RoundedRectangle(cornerRadius: 10).frame(width: 150, height: 50).foregroundColor(.gray).padding().shadow(radius: 10)
                    Text("Action")
                        .frame(width: 150, height: 30)
                        .font(.title)
                        .foregroundColor(.white)
                }
                if(self.pot < 0) {
                    Image(systemName: "questionmark.diamond").resizable().frame(width: 50, height: 50).foregroundColor(.blue)
                }
            }
            HStack {
                Text("\(game.pot)")
            }


        }
        .padding()
    }
}

#Preview {
    ContentView()
}
