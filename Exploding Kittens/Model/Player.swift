//
//  Player.swift
//  Exploding Kittens
//
//  Created by Trịnh Kiết Tường on 31/10/24.
//

import Foundation
struct Player: Identifiable{
    let id: UUID
    let name: String
    let onHandCards: [Card]
    
    init(id: UUID, name: String, onHandCards: [Card]) {
        self.id = UUID()
        self.name = name
        self.onHandCards = []
    }
}


