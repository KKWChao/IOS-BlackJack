//
//  Card.swift
//  FinalProject
//
//  Created by Kelvin Chao on 11/24/25.
//

/*
 * Kelvin Chao
 * CIS 137
 * Pacheco
 * Final Project
 * 11/24/25
 */

import SwiftUI

// * id should be set to UUID and value/suit can be set to ints as well later

struct Card: Identifiable {
    var id: UUID = UUID()
    var value: String
    var suit: String
}
