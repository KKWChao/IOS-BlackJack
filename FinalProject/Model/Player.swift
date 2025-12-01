//
//  Player.swift
//  FinalProject
//
//  Created by Kelvin Chao on 11/30/25.
//

import SwiftUI

struct Player: Identifiable {
    var id: UUID = UUID()
    var name: String
    var hand: [Card] = []
    var score: Int = 0
}
