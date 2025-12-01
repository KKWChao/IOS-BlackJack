//
//  GameViewModel.swift
//  FinalProject
//
//  Created by Kelvin Chao on 11/24/25.
//

import Foundation

class GameViewModel: ObservableObject {
    /*
     Loop for game
     
     1. Begin game with dealer and user
        a. Create deck of 52 Cards
     2. Dealer gets 2 cards, user gets 2
        a. dealer onlys shows 1 to user
     3. user choose to add to bet or no change
     4. user chooses to hit or stay
     5. If hit then add card to user hand
     6. Else game calc to see who has a better hand
     7. If User wins, user gets pot
     8. Else If User loses, user loses pot
     9. Else User gets bet back
     10. Loop back
     */
    
    // game state tracking for dealer and player
    @Published private var dealer = Player(name: "Dealer", hand: [], score: 1000)
    @Published private var mainPlayer = Player(name: "Player", hand: [], score: 10)
    @Published private var pot: Int = 0
    
    private var deck: [Card] = []

    init() {
        startGame()
    }
    
    func startGame() {
        print("Welcome to Blackjack!")
        // Creating Deck and shuffling
        createDeck()
        print(deck[0])
        
        // deal 1 to dealer
        
        // deal 1 to player
        
        // deal 2 to dealer
        
        // deal 2 to player
        
        // --- while loop, condition on hand score + player action
        
        // ask player
        
        // receive response
        
        // validate winner
        
        //
    }
    
    func createDeck() {
        let suits: [String] = ["♠️","❤️","♣️","♦️"]
        let ranks: [String] = ["1", "2", "3", "4","5","6","7","8","9","10","J","Q","K"]
        
        for suit in suits {
            for rank in ranks {
                self.deck.append(Card(value: rank, suit: suit))
            }
        }
        // shuffle deck
        self.deck.shuffle()
    }
    
    func dealCard() -> Card {
        return self.deck.removeFirst()
    }
    
    func compare() -> {
        
    }
}
