//
//  PokeListRequest.swift
//  MVVM
//
//  Created by de Oliveira, Rafael on 27/04/22.
//

import Foundation

struct PokeListRequest: Codable {
    let limit: Int
    let offset: Int
    
    func asParams() -> [String: Any] {
        return ["limit": limit, "offset": offset]
    }
}
