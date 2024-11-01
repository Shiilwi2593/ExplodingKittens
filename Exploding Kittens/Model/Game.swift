//
//  Game.swift
//  Exploding Kittens
//
//  Created by Trịnh Kiết Tường on 31/10/24.
//

import Foundation

struct Game: Codable {
    var currentTurn: String
    var players: [String]
    var deck: [String]
    var discardPile: [String]
    
    init(players: [String], deck: [String]) {
        self.currentTurn = players.first ?? ""
        self.players = players
        self.deck = deck
        self.discardPile = []
    }
    

}

