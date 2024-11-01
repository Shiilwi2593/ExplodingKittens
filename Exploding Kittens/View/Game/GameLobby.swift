//
//  GameLobby.swift
//  Exploding Kittens
//
//  Created by Trịnh Kiết Tường on 1/11/24.
//

import SwiftUI

struct GameLobby: View {
    
    let columns: [GridItem] = [
        GridItem(.flexible()),
        GridItem(.flexible()),
        GridItem(.flexible())
    ]
    var body: some View {
        ZStack(alignment: .bottom){
            VStack(alignment: .leading){
                Section(header: Text("Players").font(.title).fontWeight(.semibold)) {
                    ScrollView(.horizontal){
                        HStack(spacing: 20){
                            ForEach(1..<10){_ in
                                GroupBox{
                                    VStack{
                                        Image(systemName: "person.fill")
                                            .resizable()
                                            .aspectRatio(contentMode: .fit)
                                            .foregroundStyle(Color.black.opacity(0.6))
                                            .frame(width: 80, height: 80)
                                        
                                    }
                                    Text("Shiilwi2593")
                                        .font(.headline)
                                        .fontWeight(.semibold)
                                }
                            }
                        }
                    }
                }
                
                Section(header: Text("Cards").font(.title).fontWeight(.semibold)) {
                    let cards: [String] = ["attack1","explode1","normal1","defuse1","favor1","nope1","future1","shuffle1","skip1"]
                    LazyVGrid(columns: columns, spacing: 10, content: {
                        ForEach(cards, id: \.self){card in
                            VStack{
                                Image(card)
                                    .resizable()
                                    .aspectRatio(contentMode: .fill)
                                    .frame(width: 110, height: 150)
                                    .padding(5)
                                    .shadow(color: .black.opacity(0.4), radius: 2, x: 0, y: 10)
                            }
                        }
                    })
                }
            }
            
            
            HStack{
                NavigationLink(destination: MainView()) {
                    Circle()
                        .fill(Color.red.opacity(0.8))
                        .frame(width: 80)
                        .shadow(color: .black.opacity(0.9),radius: 20, x: 0, y: 20)
                        .overlay{
                            Image(systemName: "arrowshape.turn.up.backward.circle.fill")
                                .resizable()
                                .frame(width: 30, height: 30)
                                .foregroundStyle(.black)
                        }
                }
                
                Spacer()
                
                NavigationLink(destination:
                                GamePlayView()
                ) {
                    Circle()
                        .fill(Color.green.opacity(0.9))
                        .frame(width: 80)
                        .shadow(color: .black.opacity(0.9),radius: 20, x: 0, y: 20)
                        .overlay{
                            Image(systemName: "restart.circle.fill")
                                .resizable()
                                .frame(width: 30, height: 30)
                        }
                }
                
                
            }
        }
        .navigationBarBackButtonHidden(true)
        .padding()
        
    }
}

#Preview {
    GameLobby()
}
