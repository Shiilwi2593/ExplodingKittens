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
    @State private var showingJoinGame = false
    
    var body: some View {
        NavigationStack {
            ZStack {
                Image("explodingKittensBackground")
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                
                VStack(spacing: 25) {
                    NavigationLink(destination: CreateGameView()) {
                        Text("Create Game")
                            .foregroundColor(.white)
                    }
                    .buttonStyle(GameButtonStyle(
                        backgroundColor: Color(red: 0.9, green: 0.3, blue: 0.3),
                        shadowColor: Color(red: 0.7, green: 0.2, blue: 0.2)
                    ))
                    
                    Button(action: {
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
            .navigationBarBackButtonHidden(true)
           
        }
        
    }
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
