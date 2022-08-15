//
//  PokeDetailsResponse.swift
//  MVVM
//
//  Created by de Oliveira, Rafael on 25/04/22.
//

import Foundation

struct PokeDetailsResponse: Codable {
    let abilities: [PokeAbility]
    let id: Int
    let name: String
    let images: PokeImage
    let types: [PokeTypes]
    
    
    enum CodingKeys: String, CodingKey {
        case abilities = "abilities"
        case id = "id"
        case name = "name"
        case images = "sprites"
        case types = "types"
    }
}

struct PokeAbility: Codable {
    let ability: PokeAbilityDetail
    let isHidden: Bool
    
    enum CodingKeys: String, CodingKey {
        case ability = "ability"
        case isHidden = "is_hidden"
    }
}

struct PokeAbilityDetail: Codable {
    let name: String
}

struct PokeImage: Codable {
    let front_default: String
    let front_shiny: String
}

struct PokeTypes: Codable {
    let slot: Int
    let type: PokeType
}

struct PokeType: Codable {
    let name: String
}
