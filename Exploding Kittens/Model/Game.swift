//
//  Game.swift
//  Exploding Kittens
//
//  Created by Trịnh Kiết Tường on 31/10/24.
//

import Foundation

struct Game {
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

    mutating func nextTurn() {
        if let currentIndex = players.firstIndex(of: currentTurn) {
            let nextIndex = (currentIndex + 1) % players.count
            currentTurn = players[nextIndex]
        }
    }

    mutating func playCard(card: String) {
        if let index = deck.firstIndex(of: card) {
            deck.remove(at: index)
            discardPile.append(card)
        }
    }
}
