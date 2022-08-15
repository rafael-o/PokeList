//
//  AppSettings.swift
//  MVVM
//
//  Created by de Oliveira, Rafael on 27/04/22.
//

import Foundation

struct AppSettings {
    /// URL's da PokeAPI
    struct Poke {
        static let baseUrl = "https://pokeapi.co/api/v2/"
        static let path = "pokemon"
    }
    
    /// Custom Decoder com alteração no formato da Data recebida
    static var jsonDecoder: JSONDecoder {
        let decoder = JSONDecoder()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss"
        decoder.dateDecodingStrategy = .formatted(dateFormatter)
        return decoder
    }
    
    /// Custom Encoder com alteração no formato da Data enviada
    static var jsonEncoder: JSONEncoder {
        let encoder = JSONEncoder()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss"
        encoder.dateEncodingStrategy = .formatted(dateFormatter)
        return encoder
    }
}
