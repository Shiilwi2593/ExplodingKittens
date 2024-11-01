//
//  MainViewVM.swift
//  Exploding Kittens
//
//  Created by Trịnh Kiết Tường on 31/10/24.
//

import Foundation
import SwiftData

class MainViewVM: ObservableObject {
    @Published var cards: [Card] = []
    @Published var numberOfPlayers: Int = 4
    
    init(numberOfPlayers: Int = 4) {
        self.numberOfPlayers = max(4, min(7, numberOfPlayers))
        setupDefaultCards()
    }
    
    private func setupDefaultCards() {
        if cards.isEmpty {
            var defaultCards: [Card] = []
            
            for i in 1...numberOfPlayers - 1 {
                defaultCards.append(Card(name: "attack\(i)", type: .action(.attack), imageName: "attack\(i)"))
            }
            
            for i in 1...5 {
                let catType: CardType.CatType
                
                switch i {
                case 1: catType = .cat1
                case 2: catType = .cat2
                case 3: catType = .cat3
                case 4: catType = .cat4
                case 5: catType = .cat5
                default: continue
                }
                
                for j in 1...4 {
                    defaultCards.append(Card(name: "Normal \(catType) \(j)", type: .cat(catType), imageName: "normal\(i)"))
                }
            }
            
            for i in 1...numberOfPlayers {
                defaultCards.append(Card(name: "defuse\(i)", type: .defuse, imageName: "defuse\(i)"))
            }
            
            for i in 1...numberOfPlayers - 1 {
                defaultCards.append(Card(name: "explode\(i)", type: .exploding, imageName: "explode\(i)"))
            }
            
            // Thêm lá bài Nope (bằng số người chơi)
            for i in 1...numberOfPlayers {
                defaultCards.append(Card(name: "nope\(i)", type: .action(.nope), imageName: "nope\(i)"))
            }
            
            // Thêm lá bài See The Future (bằng số người chơi)
            for i in 1...numberOfPlayers {
                defaultCards.append(Card(name: "future\(i)", type: .action(.seeTheFuture), imageName: "future\(i)"))
            }
            
            // Thêm lá bài Shuffle (số người chơi - 1)
            for i in 1...numberOfPlayers - 1 {
                defaultCards.append(Card(name: "shuffle\(i)", type: .action(.shuffle), imageName: "shuffle\(i)"))
            }
            
            // Thêm lá bài Skip (số người chơi - 1)
            for i in 1...numberOfPlayers - 1 {
                defaultCards.append(Card(name: "skip\(i)", type: .action(.skip), imageName: "skip\(i)"))
            }
            
            // Thêm lá bài Favor (số người chơi - 1)
            for i in 1...numberOfPlayers - 1 {
                defaultCards.append(Card(name: "favor\(i)", type: .action(.favor), imageName: "favor\(i)"))
            }
            
            // Cập nhật cards
            self.cards = defaultCards
        }
    }
    
    func resetCardsForPlayerCount(_ count: Int) {
        numberOfPlayers = max(4, min(7, count))
        cards.removeAll()
        setupDefaultCards()
    }
}
