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
    // Separate view model? one for game and one for game state?
    // 0 = default
    // 1 = player wins
    // 2 = player loses
    @Published var gameState: Int = 0
    
    // TODO: need to allow for player to view dealer last card on stay()
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
     10. Call start game again
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
        
        // Clearing out for game loop
        reset()
        
        // Checking shuffled cards
//        print(deck[2])
        print("New Round")
        
        dealCard(to: &dealer)
        
        dealCard(to: &mainPlayer)
        
        dealCard(to: &dealer)
        
        dealCard(to: &mainPlayer)
        
        // Checking Hands
//        print(mainPlayer.hand[0])
//        print(mainPlayer.hand[1])
//        print(dealer.hand[0])
//        print(dealer.hand[1])
        
    }
    
    // CREATING DECK
    func createDeck() {
        let suits: [String] = ["♠️","❤️","♣️","♦️"]
        let ranks: [String] = ["1", "2", "3", "4","5","6","7","8","9","10","J","Q","K"]
        
        deck.removeAll()
        
        for suit in suits {
            for rank in ranks {
                self.deck.append(Card(value: rank, suit: suit))
            }
        }
        // shuffle deck
        self.deck.shuffle()
    }
    
    // DEAL TO PLAYER - Had to fix since dealCard wasn't working on view
    func dealToPlayer() {
        dealCard(to: &mainPlayer)
    }
    
    
    // DEALING CARD TO PLAYER
    func dealCard(to player: inout Player) {
//        print("Dealing card to \(player.name)")
        player.hand.append(deck.removeFirst())
        
        if (checkBust(player: player)) {
            print("\(player.name) bust!")
            
            // view not updating, trying to update view after bust
            // ???
            startGame()
        }
        
    }
    
    // STAY FUNCTION
    func stay() {
        // get value of dealer hand
        var dealerValue: Int = handValue(player: dealer)
        
        // if value < 17, hit dealer
        while dealerValue < 17 {
            dealCard(to: &dealer)
            sleep(2)

            dealerValue = handValue(player: dealer)
            
            if dealerValue > 21 {
                print("Dealer busts!")
            }
            print(dealerValue)
        }
        
        // TODO: add a pause so player can see dealt card
        
    
        // compare value between player and dealer
        print("\(compare()) wins")
        startGame()
    }
    
    // GAME RESET
    func reset() {
        mainPlayer.hand.removeAll()
        dealer.hand.removeAll()
        createDeck()
        gameState = 0
    }
    
    // CALCULATE HAND VALUES
    func handValue(player: Player) -> Int {
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
                if score > 11 {
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
    
    // CHECKING BUST
    func checkBust(player: Player) -> Bool {
        return handValue(player: player) > 21 ? true : false
    }
    
    // HAND COMPARISON
    func compare() -> String {
        // need to convert rank to int value
    
        let playerHand: Int = handValue(player: self.mainPlayer)
        let dealerHand: Int = handValue(player: self.dealer)
        
        if playerHand > 21 {
            return dealer.name
        }
        if dealerHand > 21 {
            return mainPlayer.name
        }
        
        if playerHand == 21 {
            return mainPlayer.name
        }
        if dealerHand == 21 {
            return dealer.name
        }
        
        if playerHand > dealerHand {
            return mainPlayer.name
        }
        if playerHand < dealerHand {
            return dealer.name
        }
    
        return "Tie"
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
