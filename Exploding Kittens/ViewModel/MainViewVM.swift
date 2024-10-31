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
    
    init() {
        setupDefaultCards()
    }
    
    private func setupDefaultCards() {
        if cards.isEmpty {
            var defaultCards: [Card] = []
            
            // Thêm lá bài Action Attack
            for i in 1...6 {
                defaultCards.append(Card(name: "attack\(i)", type: .action(.attack), imageName: "attack\(i)"))
            }
            
            // Thêm các lá bài Cat
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
                
                // Thêm 4 lá bài Normal cho mỗi CatType
                for _ in 1...4 {
                    defaultCards.append(Card(name: "Normal \(i)", type: .cat(catType), imageName: "normal\(i)"))
                }
            }
            
            // Thêm lá bài Defuse
            for i in 1...7 {
                defaultCards.append(Card(name: "defuse\(i)", type: .defuse, imageName: "defuse\(i)"))
            }
            
            // Thêm lá bài Exploding
            for i in 1...6 {
                defaultCards.append(Card(name: "explode\(i)", type: .exploding, imageName: "explode\(i)"))
            }
            
            // Thêm lá bài Nope
            for i in 1...5 {
                defaultCards.append(Card(name: "nope\(i)", type: .action(.nope), imageName: "nope\(i)"))
            }
            
            // Thêm lá bài See The Future
            for i in 1...5 {
                defaultCards.append(Card(name: "future\(i)", type: .action(.seeTheFuture), imageName: "future\(i)"))
            }
            
            // Thêm lá bài Shuffle
            for i in 1...4 {
                defaultCards.append(Card(name: "shuffle\(i)", type: .action(.shuffle), imageName: "shuffle\(i)"))
            }
            
            // Thêm lá bài Skip
            for i in 1...4 {
                defaultCards.append(Card(name: "skip\(i)", type: .action(.skip), imageName: "skip\(i)"))
            }
            
            // Cập nhật cards
            self.cards = defaultCards
        }
    }
    
   
}
