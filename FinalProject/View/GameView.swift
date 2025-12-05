//
//  GameView.swift
//  FinalProject
//
//  Created by Kelvin Chao on 12/3/25.
//

import SwiftUI

struct GameView: View {
    var playerName: String = ""
    
    @StateObject private var game = GameViewModel(playerName: "KC")
    
    @State private var potScale = 1.0
    @State private var bg = Color.green;

    
    var body: some View {
        VStack {
            HStack {
                Text("Welcome!\nPlayer: \(playerName)").foregroundStyle(bg).font(.title2)
                Spacer()
                NavigationLink(destination: EndView()) {
                    Text("End Game?")
                }
            }
            

            ZStack {
                RoundedRectangle(cornerRadius: 10).fill(bg).shadow(radius: 5)
                VStack {
                    Spacer()
                    HStack() {
//                        RoundedRectangle(cornerRadius: 10).fill(Color.gray).frame(width: 80, height: 120)
                        ForEach(game.dealer.hand) { card in
                            CardView(card: card)
                        }
                        
                    }
                    Spacer()
                    
                    ZStack {
                        Circle().fill(Color.white).frame(width: 80)
                        Text("\(game.pot)").fontWeight(.bold).foregroundColor(.blue).font(.title).scaleEffect(potScale)
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
            
            HStack {
                if(game.pot >= 15) {
                    Image(systemName: "exclamationmark.triangle").resizable().frame(width: 50, height: 50).foregroundColor(.red)
                }

                ZStack {

                    Circle().fill(Color.yellow).frame(width: 100, height: 100).padding()
                    Text("Bet?")
                        .frame(width: 100, height: 100)
                        .font(.title)
                        .foregroundColor(.white).contextMenu {
                            Button(action: {
                                game.addToPot(5)
                                self.potScale += 0.2
                            }) {
                                Text("Add")
                                Image(systemName: "plus")
                            }
                            Button(action: {
                                game.removeFromPot(5)
                                self.potScale -= 0.2
                            }) {
                                Text("Subtract")
                                Image(systemName: "minus")
                            }
                            Button(action: {
                                game.pot = 0
                                self.potScale = 1
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
                        
                        Button(action: {
                            game.dealToPlayer()
                            
                        }) {
                            Text("Hit")
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

                
                if(game.pot < 0) {
                    Image(systemName: "questionmark.diamond").resizable().frame(width: 50, height: 50).foregroundColor(.blue)
                }
            }
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
                Text("\(game.pot)").font(.title).padding()
            }

        }
        .padding(5).navigationBarBackButtonHidden()
    }
}

#Preview {
    GameView()
}
