//
//  CardList.swift
//  Exploding Kittens
//
//  Created by Trịnh Kiết Tường on 31/10/24.
//

import SwiftUI
import SwiftData

struct CardList: View {
    @StateObject private var mainVM = MainViewVM()
    let columns: [GridItem] = [
        GridItem(.flexible()),
        GridItem(.flexible())
    ]
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 20) {
                CardSectionView(
                    title: "Exploding Kittens",
                    cards: mainVM.cards.filter { $0.type == .exploding },
                    columns: columns
                )
                
                CardSectionView(
                    title: "Defuse Cards",
                    cards: mainVM.cards.filter { $0.type == .defuse },
                    columns: columns
                )
                
                CardSectionView(
                    title: "Action Cards",
                    cards: mainVM.cards.filter {
                        switch $0.type {
                        case .action(_): return true
                        default: return false
                        }
                    },
                    columns: columns
                )
                
                CardSectionView(
                    title: "Cat Cards",
                    cards: mainVM.cards.filter {
                        switch $0.type {
                        case .cat(_): return true
                        default: return false
                        }
                    },
                    columns: columns
                )
            }
            .padding()
        }
    }
}

struct CardSectionView: View {
    let title: String
    let cards: [Card]
    let columns: [GridItem]
    
    var body: some View {
        if !cards.isEmpty {
            VStack(alignment: .leading) {
                Text(title)
                    .font(.headline)
                    .padding(.horizontal)
                
                LazyVGrid(columns: columns) {
                    ForEach(cards) { card in
                        VStack {
                            Image(card.imageName)
                                .resizable()
                                .aspectRatio(contentMode: .fill)
                                .cornerRadius(10)
                                .shadow(radius: 20, x: 0, y: 10)
                        }
                        .padding()
                    }
                }
            }
        }
    }
}

#Preview {
    CardList()
}
