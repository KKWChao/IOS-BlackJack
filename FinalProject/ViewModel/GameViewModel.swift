//
//  GameViewModel.swift
//  FinalProject
//
//  Created by Kelvin Chao on 11/24/25.
//

import Foundation

class GameViewModel: ObservableObject {
    // TODO: Need to figure out how to pass the name to the game state
    // @Published var playerName: String = ""
    
    // TODO: Add state for quit, WIN OR LOSE? states or 0, 1, 2?
    
    /*
     Loop for game
     
     1. Begin game with dealer and user
        a. Create deck of 52 Cards [x]
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
    @Published var dealer = Player(name: "Dealer", hand: [], score: 1000)
    @Published var mainPlayer = Player(name: "", hand: [], score: 10)
    @Published var pot: Int = 0
    
    private var deck: [Card] = []

    init(playerName: String) {
        self.mainPlayer.name = playerName
        startGame()
    }
    
    // TODO: Finish Game Loop
    func startGame() {
        print("Welcome to Blackjack!")
        
        // Creating Deck and shuffling
        createDeck()
        
        // Checking shuffled cards
        print(deck[2])
        
        // deal 1 to dealer - pass the dealer in
        dealCard(player: &dealer)
        
        // deal 1 to player
        dealCard(player: &mainPlayer)
        
        // deal 2 to dealer
        dealCard(player: &dealer)
        
        // deal 2 to player
        dealCard(player: &mainPlayer)
        
        // Checking Hands
        print(mainPlayer.hand[0])
        print(mainPlayer.hand[1])
        print(dealer.hand[0])
        print(dealer.hand[1])
        
        // --- while loop, condition on hand score + player action
        while (handScore(player: mainPlayer) < 21) {
            // ask player
            dealCard(player: &mainPlayer)
            print(mainPlayer.hand)
            // receive response
            
            // validate winner
            
            //
            break
        }
        
    
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
    
    // Dealing Card from Deck to a specific player
        // inout to modify parameter
    func dealCard(player: inout Player) {
        print("Dealing card to \(player.name)")
        print("Deck count: \(deck.count)")
        
        player.hand.append(deck.removeFirst())
        print(player.hand)
    }
    
    
    // Calculating hand score
    func handScore(player: Player) -> Int {
        var score: Int = 0
        
        // make an array of values from the player hand
        var copy: [String] = []
        
        // adding the values to the copy
        for card in player.hand {
            copy.append(card.value)
        }
        
        // sorting in reverse - makes 1 at the end so can deal with ace case
        copy.sort()
        copy.reverse()
        
        // create a copy to make sure 'A' is the first
        // sort the copy with sort()
        // use a reversed for loop to calcute to have A or 1 at the end to check for
        //      space of 11 or 1
        
        // loop cards in hand
        for value in copy {
            if value == "J" || value == "Q" || value == "K" {
                score += 10
            } else if value == "1" {
                // A can be either 11 or 1
                if score + 11 > 21 {
                    score += 1
                } else {
                    score += 11
                }
            } else {
                score += Int(value)!
            }
        }
        
        return score
    }
    
    func compare() -> Player {
        // need to convert rank to int value
    
        let playerHand: Int = handScore(player: self.dealer)
        let dealerHand: Int = handScore(player: self.mainPlayer)
        
        if playerHand == 21 || dealerHand > 21 {
            return self.mainPlayer
        } else if dealerHand == 21 || playerHand > 21 {
            return self.dealer
        } else if playerHand > dealerHand {
            return self.mainPlayer
        } else if playerHand < dealerHand {
            return self.dealer
        } else {
            print("Error")
        }
        
        
        return self.mainPlayer
    }
    
    // Pot Functions
    func addToPot(_ amount: Int) {
        self.pot += 5
    }
    
    func removeFromPot(_ amount: Int) {
        self.pot -= 5
    }
    
    func resetPot() {
        self.pot = 0
    }
}
