# IOS Blackjack

A minimal iOS Blackjack game built with Swift and MVVM architecture. Players start with a coin balance and place bets before each round. The goal is simple: beat the dealer without busting.

## Features

- Classic blackjack game
- MVVM Architecture
- Score based on user coins
- Uesr actions vs Dealer actions

## How to Play
1. Enter your name to start then press "Start Game"
2. Tap "Bet" to add more to the pot
3. Long press "Bet" to remove from the bet or reset the value
4. Press "Hit" to get a card
5. Press "Stay" to stay
6. Press "New Game" to start a new round
7. Press "End Game" to finish and view final score 

## Architecture

### Models
- Card: id, value, suit
- Player: id, name, hand, score

### Views
- StartView: Start Screen
- CardView: View for each card
- GameView: Main game view
- EndView: Game over view

### View Model
- GameViewModel: Handles game logic

```
FinalProject/
├── Model/
|   ├── Card.swift
│   └── Player.swift
│
├── Views/
│   ├── CardView.swift
│   ├── EndView.swift
│   ├── GameView.swift
│   └── StartView.swift
│
├── ViewModels/
│   └── GameViewModel.swift
│
├── ContentView.swift
│
└── FinalProjectApp.swift

```

## Tech Stack
- Language: Swift
- Framework: SwiftUI
- Platform: iOS 16+
- Architecture: MVVM (Model-View-ViewModel)

