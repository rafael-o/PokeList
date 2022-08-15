//
//  PokeListResponse.swift
//  MVVM
//
//  Created by de Oliveira, Rafael on 25/04/22.
//

import Foundation

struct PokeListResponse: Codable {
    let pokemon: [PokeResume]
    
    enum CodingKeys: String, CodingKey {
        case pokemon = "results"
    }
}

struct PokeResume: Codable {
    let poke: String
    
    enum CodingKeys: String, CodingKey {
        case poke = "name"
    }
}
