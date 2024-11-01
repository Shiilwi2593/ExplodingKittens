//
//  File.swift
//  Exploding Kittens
//
//  Created by Trịnh Kiết Tường on 31/10/24.
//

import Foundation

enum CardType: Codable, Equatable {
    case exploding
    case defuse
    case action(ActionType)
    case cat(CatType)
    
    enum CodingKeys: String, CodingKey {
        case type
        case action
        case cat
    }
    
    enum ActionType: String, Codable {
        case attack
        case skip
        case seeTheFuture
        case shuffle
        case favor
        case nope
    }
    
    enum CatType: String, Codable {
        case cat1
        case cat2
        case cat3
        case cat4
        case cat5
    }
    

    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        switch self {
        case .exploding:
            try container.encode("exploding", forKey: .type)
        case .defuse:
            try container.encode("defuse", forKey: .type)
        case .action(let actionType):
            try container.encode("action", forKey: .type)
            try container.encode(actionType, forKey: .action)
        case .cat(let catType):
            try container.encode("cat", forKey: .type)
            try container.encode(catType, forKey: .cat)
        }
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        let type = try container.decode(String.self, forKey: .type)
        
        switch type {
        case "exploding":
            self = .exploding
        case "defuse":
            self = .defuse
        case "action":
            let actionType = try container.decode(ActionType.self, forKey: .action)
            self = .action(actionType)
        case "cat":
            let catType = try container.decode(CatType.self, forKey: .cat)
            self = .cat(catType)
        default:
            throw DecodingError.dataCorruptedError(forKey: .type, in: container, debugDescription: "Invalid card type")
        }
    }
}

class Card: Identifiable {
    var id: UUID
    var name: String
    var type: CardType
    var imageName: String
    
    init(name: String, type: CardType, imageName: String) {
        self.id = UUID()
        self.name = name
        self.type = type
        self.imageName = imageName
    }
}
