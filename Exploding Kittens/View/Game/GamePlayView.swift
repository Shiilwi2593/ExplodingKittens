//
//  GamePlayView.swift
//  Exploding Kittens
//
//  Created by Trịnh Kiết Tường on 1/11/24.
//
import SwiftUI

struct GamePlayView: View {
    let cardUsed: [Card] = [
        Card(name: "favor1", type: .action(.favor), imageName: "favor1"),
        Card(name: "future1", type: .action(.seeTheFuture), imageName: "future1"),
        Card(name: "normal1", type: .cat(.cat1), imageName: "normal1"),
        Card(name: "normal2", type: .cat(.cat2), imageName: "normal2")
    ]
    
    let onHand: [Card] = [
        Card(name: "favor1", type: .action(.favor), imageName: "favor1"),
        Card(name: "future1", type: .action(.seeTheFuture), imageName: "future1"),
        Card(name: "normal1", type: .cat(.cat1), imageName: "normal1"),
        Card(name: "normal2", type: .cat(.cat2), imageName: "normal2"),
        Card(name: "normal4", type: .cat(.cat4), imageName: "normal4"),
        Card(name: "defuse1", type: .defuse, imageName: "defuse1")
    ]
    
    var body: some View {
        GeometryReader { geometry in
            ZStack {
                // Background gradient
                LinearGradient(
                    gradient: Gradient(colors: [Color.purple.opacity(0.6), Color.blue.opacity(0.4)]),
                    startPoint: .topLeading,
                    endPoint: .bottomTrailing
                )
                .edgesIgnoringSafeArea(.all)
                
                VStack(spacing: 15) {
                    // Desk section
                        ScrollView(.horizontal, showsIndicators: false) {
                            HStack(spacing: 10) {
                                ForEach(cardUsed) { card in
                                    CardView(card: card)
                                        .frame(width: geometry.size.width * 0.35, height: geometry.size.height * 0.25) // Use geometry.size
                                }
                            }
                            .padding(.horizontal)
                        }
                    
                    
                    // Main control section
                    HStack(spacing: 20) {
                        VStack(spacing: 15) {
                            ActionCircleButton(
                                systemImage: "square.3.layers.3d.top.filled",
                                text: "Draw",
                                color: .green
                            ) {
                                print("Draw")
                            }
                            
                            ActionCircleButton(
                                systemImage: "shuffle",
                                text: "Shuffle",
                                color: .blue
                            ) {
                                print("Shuffle")
                            }
                        }
                        
                        Image("backSide")
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .frame(width: geometry.size.width * 0.35, height: geometry.size.height * 0.2) // Use geometry.size
                            .shadow(radius: 10)
                        
                        VStack(spacing: 15) {
                            ActionCircleButton(
                                systemImage: "eye.fill",
                                text: "See Future",
                                color: .orange
                            ) {
                                print("See the future")
                            }
                            
                            ActionCircleButton(
                                systemImage: "rectangle.and.hand.point.up.left.fill",
                                text: "Insert",
                                color: .red
                            ) {
                                print("Insert exploding")
                            }
                        }
                    }
                    .padding()
                    
                    // Hand section
                    VStack(alignment: .leading) {
                        Text("Your Hand")
                            .font(.headline)
                            .fontWeight(.bold)
                            .foregroundColor(.black)
                            .padding(.horizontal)
                        
                        ScrollView(.horizontal, showsIndicators: false) {
                            LazyHGrid(rows: [GridItem(.flexible())], spacing: 10) {
                                ForEach(onHand) { card in
                                    CardView(card: card)
                                        .frame(width: geometry.size.width * 0.2, height: geometry.size.height * 0.25) // Use geometry.size
                                }
                            }
                            .padding(.horizontal)
                        }
                        .frame(height: geometry.size.height * 0.25) // Use geometry.size
                    }
                    .background(
                        RoundedRectangle(cornerRadius: 20)
                            .fill(Color.white.opacity(0.2))
                            .shadow(radius: 10)
                    )
                    
                    // Bottom control buttons
                    HStack {
                        CustomButton(text: "Take Card", color: .purple) {
                            print("Take card left")
                        }
                        
                        Spacer()
                        
                        CustomButton(text: "Take Card", color: .blue) {
                            print("Take card right")
                        }
                    }
                    .padding()
                }
            }
        }
    }
}

// Custom Card View
struct CardView: View {
    let card: Card
    
    var body: some View {
        Image(card.imageName)
            .resizable()
            .aspectRatio(contentMode: .fit)
            .frame(width: 150, height: 190)
            .cornerRadius(15)
            .shadow(radius: 5)
            .overlay(
                RoundedRectangle(cornerRadius: 15)
                    .stroke(Color.white.opacity(0.3), lineWidth: 2)
            )
    }
}

// ActionCircleButton
struct ActionCircleButton: View {
    let systemImage: String
    let text: String
    let color: Color
    let action: () -> Void
    
    var body: some View {
        Button(action: action) {
            VStack {
                Image(systemName: systemImage)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 30, height: 30)
                    .foregroundColor(.white)
                
                Text(text)
                    .font(.caption)
                    .foregroundColor(.white)
            }
            .frame(width: 80, height: 80)
            .background(
                LinearGradient(
                    gradient: Gradient(colors: [color.opacity(0.7), color.opacity(0.9)]),
                    startPoint: .top,
                    endPoint: .bottom
                )
            )
            .clipShape(Circle())
            .shadow(color: color.opacity(0.5), radius: 6, x: 0, y: 3)
        }
    }
}

// CustomButton
struct CustomButton: View {
    let text: String
    let color: Color
    let action: () -> Void
    
    var body: some View {
        Button(action: action) {
            Text(text)
                .fontWeight(.bold)
                .foregroundColor(.white)
                .padding()
                .background(
                    LinearGradient(
                        gradient: Gradient(colors: [color.opacity(0.7), color.opacity(0.9)]),
                        startPoint: .leading,
                        endPoint: .trailing
                    )
                )
                .cornerRadius(15)
                .shadow(color: color.opacity(0.5), radius: 5, x: 0, y: 3)
        }
    }
}

#Preview {
    GamePlayView()
}
