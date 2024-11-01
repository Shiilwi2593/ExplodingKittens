//
//  CreateGameView.swift
//  Exploding Kittens
//
//  Created by Trịnh Kiết Tường on 1/11/24.
//
import SwiftUI

struct CreateGameView: View {
    @State private var playerName: String = ""
    @State private var selectedPlayerCount: Int = 4
    @State private var isNameEmpty = false
    @State private var navigateToLobby = false
    
    private let gradient = LinearGradient(
        colors: [Color(hex: "FF6B6B"), Color(hex: "4ECDC4")],
        startPoint: .topLeading,
        endPoint: .bottomTrailing
    )
    
    private func createGame() {
        guard !playerName.trimmingCharacters(in: .whitespaces).isEmpty else {
            isNameEmpty = true
            return
        }
        
        navigateToLobby = true
    }
    
    var body: some View {
        NavigationStack {
            ZStack {
                gradient
                    .ignoresSafeArea()
                
                VStack(spacing: 30) {
                    // Title Section
                    VStack(spacing: 10) {
                        Image(systemName: "flame.fill")
                            .font(.system(size: 60))
                            .foregroundColor(.white)
                        
                        Text("Create a New Game")
                            .font(.system(size: 32, weight: .bold, design: .rounded))
                            .foregroundColor(.white)
                    }
                    .padding(.top, 40)
                    
                    // Player Name Input
                    VStack(alignment: .leading, spacing: 8) {
                        Text("Your Name")
                            .font(.headline)
                            .foregroundColor(.white)
                        
                        TextField("", text: $playerName)
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                            .padding(.horizontal, 16)
                            .frame(height: 50)
                            .background(Color.white.opacity(0.2))
                            .cornerRadius(12)
                            .overlay(
                                RoundedRectangle(cornerRadius: 12)
                                    .stroke(Color.white.opacity(0.3), lineWidth: 1)
                            )
                            .onChange(of: playerName) { _, _ in
                                isNameEmpty = false
                            }
                    }
                    .padding(.horizontal)
                    
                    VStack(alignment: .leading, spacing: 8) {
                        Text("Number of Players")
                            .font(.headline)
                            .foregroundColor(.white)
                        
                        ScrollView(.horizontal, showsIndicators: false) {
                            HStack(spacing: 15) {
                                ForEach(4...7, id: \.self) { count in
                                    PlayerCountButton(
                                        count: count,
                                        isSelected: selectedPlayerCount == count,
                                        action: { selectedPlayerCount = count }
                                    )
                                }
                            }
                            .padding(.horizontal)
                        }
                    }
                    .padding(.horizontal)
                    
                    Button(action: createGame) {
                        HStack {
                            Text("Create Game")
                                .font(.headline)
                            Image(systemName: "arrow.right.circle.fill")
                        }
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity)
                        .frame(height: 56)
                        .background(Color(hex: "FF6B6B"))
                        .cornerRadius(16)
                        .shadow(radius: 10)
                    }
                    .padding(.horizontal)
                    .padding(.top, 20)
                    
                    Spacer()
                }
            }
            .navigationBarHidden(true)
            .alert(isPresented: $isNameEmpty) {
                Alert(title: Text("Alert"),
                      message: Text("Name cannot be empty"),
                      dismissButton: .default(Text("OK")) {
                        playerName = ""
                      }
                )
            }
            .navigationDestination(isPresented: $navigateToLobby) {
                GameLobby()
            }
        }
    }
}

// Helper Views
struct PlayerCountButton: View {
    let count: Int
    let isSelected: Bool
    let action: () -> Void
    
    var body: some View {
        Button(action: action) {
            VStack(spacing: 8) {
                Image(systemName: "person.3.fill")
                    .font(.system(size: 24))
                Text("\(count)")
                    .font(.headline)
            }
            .foregroundColor(isSelected ? .white : .white.opacity(0.6))
            .frame(width: 80, height: 80)
            .background(isSelected ? Color(hex: "FF6B6B") : Color.white.opacity(0.2))
            .cornerRadius(12)
            .overlay(
                RoundedRectangle(cornerRadius: 12)
                    .stroke(Color.white.opacity(0.3), lineWidth: 1)
            )
        }
    }
}



#Preview {
    CreateGameView()
}
