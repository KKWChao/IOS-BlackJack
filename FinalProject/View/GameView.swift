//
//  GameView.swift
//  FinalProject
//
//  Created by Kelvin Chao on 12/3/25.
//

/*
 * Kelvin Chao
 * CIS 137
 * Pacheco
 * Final Project
 * 11/24/25
 */

import SwiftUI

struct GameView: View {
    var playerName: String = ""

    @StateObject private var game: GameViewModel
    
    init(playerName: String) {
        _game = StateObject(wrappedValue: GameViewModel(playerName: playerName))
    }
    
    @State private var bg = Color.green;

    
    var body: some View {
        VStack {
            // HEADER AREA
            HStack {
                Text("Welcome!\nPlayer: \(game.mainPlayer.name)").foregroundStyle(bg).font(.title2)
                Spacer()
                NavigationLink(destination: EndView(playerName: game.mainPlayer.name, score: game.mainPlayer.score)) {
                    Text("End Game?")
                }.buttonStyle(.bordered).foregroundColor(.blue).padding(.horizontal)
            }
            
            // MAIN GAME AREA
            ZStack {
                RoundedRectangle(cornerRadius: 10).fill(bg).shadow(radius: 5)
                VStack {
                    Spacer()
                    HStack() {
                        // TODO: Need to figure out how to hide first card
//                        RoundedRectangle(cornerRadius: 10).fill(Color.gray).frame(width: 80, height: 120)
                        ForEach(game.dealer.hand) { card in
                            CardView(card: card)
                        }
                    }
                    Spacer()
                    
                    ZStack {
                        Circle().fill(Color.yellow).frame(width: 100)
                        
                        if (game.gameState != .gameOver) {
                            Text("\(game.pot)").fontWeight(.bold).foregroundColor(.blue).font(.title)
                        } else {
                            ZStack {
                                bg.opacity(0.85)
                                
                                VStack {
                                    Text("\(game.winner) Wins!").font(.title).foregroundStyle(.white)
                                    Text("\(game.winner == "Dealer" ? "-" : "+") \(game.pot)").foregroundStyle(Color.yellow).font(.title).fontWeight(.bold)
                                }
                            }.frame(width: 300, height: 100)


                        }
                    }

                    Spacer()
                    
                    HStack {
                        ForEach(game.mainPlayer.hand) { card in
                            CardView(card: card)
                        }
                    }
                    Spacer()
                }
            
            }
            
            // PLAYER ACTION AREA
            HStack {
                ZStack {
                    // color ternary based on state
                    Circle().fill(game.gameState == .betting ? Color.blue : Color.gray).frame(width: 100, height: 100).padding()
                    Text("Bet?")
                        .frame(width: 100, height: 100)
                        .font(.title)
                        .foregroundColor(.white)
                        .onTapGesture(perform: {
                            game.addToPot()
                        })
                        .contextMenu {
                            Button(action: {
                                game.removeFromPot()
                            }) {
                                Text("Subtract")
                                Image(systemName: "minus")
                            }
                            Button(action: {
                                game.resetPot()
                            }) {
                                Text("Reset")
                                Image(systemName: "eraser")
                            }
                        }
                    
                }
                Spacer()
                
                VStack {
                    // dealing the card
                    ZStack {
                        RoundedRectangle(cornerRadius: 10).frame(width: 150, height: 50).foregroundColor(bg).shadow(radius: 10)
                        
                        if (game.gameState == .betting || game.gameState == .playerTurn) {
                            Button(action: {
                                game.dealToPlayer()
                                
                            }) {
                                Text("Hit")
                                    .frame(width: 150, height: 30)
                                    .font(.title)
                                    .foregroundColor(.white)
                            }
                        } else if (game.mainPlayer.score > 0) {
                            Button(action: {
                                game.startGame()
                            }) {
                                Text("Next Round")
                                    .frame(width: 150, height: 30)
                                    .font(.title)
                                    .foregroundColor(.white)
                            }
                        } else {
                            Text("Game Over")
                                .frame(width: 150, height: 30)
                                .font(.title)
                                .foregroundColor(.white)
                        }

                    }
                    // Stay
                    ZStack {
                        RoundedRectangle(cornerRadius: 10).frame(width: 150, height: 50).foregroundColor(.gray).shadow(radius: 10)
                        
                        Button(action: {
                            game.stay()
                        }) {
                            Text("Stay")
                                .frame(width: 150, height: 30)
                                .font(.title)
                                .foregroundColor(.white)
                        }

                    }
                }.padding()
            }
            
            // THEME CHOICE AND PLAYER SCORE
            HStack {
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

                Spacer()
                Text("My Coins: \(game.mainPlayer.score)").font(.title).foregroundColor(Color.primary).padding()
            }

        }
        .padding(5).navigationBarBackButtonHidden()
    }
}

#Preview {
    GameView(playerName: "KC")
}
