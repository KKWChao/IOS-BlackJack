//
//  GameViewModel.swift
//  FinalProject
//
//  Created by Kelvin Chao on 11/24/25.
//

import Foundation

class GameViewModel: ObservableObject {
    // TODO: Need to figure out how to pass the name to the game state
    
    // Game State: betting -> deal cards -> player choice -> dealer update -> game check -> betting
    @Published var gameState: GameState = .betting
    /*
     Loop for game
     
     1. Begin game with dealer and user [x]
        a. Create deck of 52 Cards [x]
     2. Dealer gets 2 cards, user gets 2 [x]
        a. dealer onlys shows 1 to user []
     3. user choose to add to bet or no change []
     4. user chooses to hit or stay [x]
     5. If hit then add card to user hand [x]
     6. Else game calc to see who has a better hand [x]
     7. If User wins, user gets pot []
     8. Else If User loses, user loses pot []
     9. Else User gets bet back []
     10. Call start game again
     */
    
    // game state tracking for dealer and player
    @Published var dealer = Player(name: "Dealer", hand: [], score: 1000)
    @Published var mainPlayer = Player(name: "test", hand: [], score: 10)
    @Published var pot: Int = 1
    @Published var winner: String = ""
    
    
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
        gameState = .playerTurn
        
        if (handValue(player: mainPlayer) > 21) {
            gameState = .checking
            winner = dealer.name
        } 
    }
    
    
    // DEALING CARD TO PLAYER
    func dealCard(to player: inout Player) {
//        print("Dealing card to \(player.name)")
        let card: Card = deck.removeFirst()
        
        // had to add this to make sure hands update on view side, Player is a struct which doesn't keep track of mutations
        player.hand = player.hand + [card]
    }
    
    
    // STAY FUNCTION - Dealers turn
    func stay() {
        gameState = .dealerTurn
        
        // get value of dealer hand
        var dealerValue: Int = handValue(player: dealer)
        
        // if value < 17, hit dealer
        while dealerValue < 17 && gameState == .dealerTurn {
            dealCard(to: &dealer)
            dealerValue = handValue(player: dealer)
        }
        
        // Dealer will stay at hand value > 17
        if (dealerValue > 17 && dealerValue < 22) {
            gameState = .checking
        }
        
        if dealerValue > 21 {
            gameState = .checking
            winner = mainPlayer.name
        }
        
        // TODO: add a pause so player can see dealt card
        dealer = dealer // force reload
        
        // compare value between player and dealer
        compare()
    }
    
    // GAME RESET
    func reset() {
        mainPlayer.hand.removeAll()
        dealer.hand.removeAll()
        createDeck()
        winner = ""
        gameState = .betting
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
    
    
    // HAND COMPARISON
    func compare() {
        // need to convert rank to int value
        
        let playerHand: Int = handValue(player: self.mainPlayer)
        let dealerHand: Int = handValue(player: self.dealer)
        
        // maybe move this to hit()
        if playerHand > 21 || dealerHand == 21 && playerHand != 21 {
            resetPot()
            winner = dealer.name
        }
        // move this to stay()
        if dealerHand > 21 || playerHand == 21 {
            mainPlayer.score += pot * 2
            resetPot()
            winner = mainPlayer.name
        }
        // FIX THIS double checking
        // Need this to check end game and check value when dealer stays ie value > 17
        if (gameState == .checking && playerHand < 22 && dealerHand < 22) {
            
            print("Checking")
            
            if playerHand > dealerHand {
                mainPlayer.score += pot * 2
                resetPot()
                winner = mainPlayer.name
            }
            if playerHand < dealerHand {
                resetPot()
                winner = dealer.name
            }
        }
    }

    
    // POT FUNCTION
    func addToPot() {
        // no betting if player has hit
        if (gameState != .betting) {return}
        
        // removing form player score
        if (mainPlayer.score == 0) {return}
        pot += 1
        mainPlayer.score -= 1
    }
    
    func removeFromPot() {
        // no betting if player has hit
        if (gameState != .betting) {return}
        
        // make sure player cant go into neg
        if (pot == 1) { return }
        pot -= 1
    }
    
    func resetPot() {
        // no betting if player has hit
        if (gameState != .betting) {return}
        
        if (pot != 1) {
            mainPlayer.score += pot - 1
            pot = 1
        }
    }
}

// for game state progression
enum GameState {
    case betting
    case dealing
    case playerTurn
    case dealerTurn
    case checking
}
