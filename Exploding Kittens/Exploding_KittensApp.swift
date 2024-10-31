//
//  Exploding_KittensApp.swift
//  Exploding Kittens
//
//  Created by Trịnh Kiết Tường on 31/10/24.
//

import SwiftUI
import SwiftData

@main
struct Exploding_KittensApp: App {
    var body: some Scene {
        WindowGroup {
            NavigationStack{
                MainView()
                    .modelContainer(for: Card.self)
            }
        }
    }
}
