//
//  MainView.swift
//  Exploding Kittens
//
//  Created by Trịnh Kiết Tường on 31/10/24.
//

import SwiftUI
import SwiftData

struct MainView: View {
    @StateObject private var mainViewVM = MainViewVM()
    @Environment(\.modelContext) private var context
    @Query var cards: [Card]
    
    var body: some View {
        NavigationStack {
            ZStack {
                Image("explodingKittensBackground")
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .ignoresSafeArea()
                
                VStack(spacing: 25) {
                    Button(action: {
                        print("Create Game")
                    }) {
                        Text("Create Game")
                            .foregroundColor(.white)
                    }
                    .buttonStyle(GameButtonStyle(
                        backgroundColor: Color(red: 0.9, green: 0.3, blue: 0.3),
                        shadowColor: Color(red: 0.7, green: 0.2, blue: 0.2)
                    ))
                    
                    Button(action: {
                        print("Join Game")
                    }) {
                        Text("Join Game")
                            .foregroundColor(.white)
                    }
                    .buttonStyle(GameButtonStyle(
                        backgroundColor: Color(red: 0.3, green: 0.7, blue: 0.3),
                        shadowColor: Color(red: 0.2, green: 0.5, blue: 0.2)
                    ))
                    
                    NavigationLink(destination: CardList()) {
                        Text("Card List")
                            .foregroundColor(.white)
                    }
                    .buttonStyle(GameButtonStyle(
                        backgroundColor: Color(red: 0.3, green: 0.4, blue: 0.9),
                        shadowColor: Color(red: 0.2, green: 0.3, blue: 0.7)
                    ))
                }
                .padding(.horizontal, 40)
            }
            .onAppear {
                let viewModelCards = mainViewVM.cards
                print("Total cards: \(viewModelCards.count)")
                for card in viewModelCards {
                    print("Card: \(card.name)")
                }
                do {
                    try context.save()
                } catch {
                    print("Save error: \(error.localizedDescription)")
                }
            }
        }
    }
}

#Preview {
    MainView()
}


struct GameButtonStyle: ButtonStyle {
    var backgroundColor: Color
    var shadowColor: Color
    
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .font(.custom("Arial Rounded MT Bold", size: 24))
            .padding(.vertical, 15)
            .padding(.horizontal, 30)
            .frame(maxWidth: .infinity)
            .background(
                ZStack {
                    RoundedRectangle(cornerRadius: 15)
                        .fill(backgroundColor)
                    
                    RoundedRectangle(cornerRadius: 15)
                        .stroke(Color.black, lineWidth: 3)
    
                    RoundedRectangle(cornerRadius: 15)
                        .stroke(Color.white.opacity(0.3), lineWidth: 2)
                        .padding(3)
                }
            )
            .shadow(color: shadowColor, radius: 0, x: 0, y: 4)
            .scaleEffect(configuration.isPressed ? 0.95 : 1.0)
            .offset(y: configuration.isPressed ? 4 : 0)
            .animation(.spring(response: 0.2, dampingFraction: 0.9), value: configuration.isPressed)
    }
}
#Preview {
    MainView()
}
