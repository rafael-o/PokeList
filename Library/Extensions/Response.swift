//
//  Response.swift
//  MVVM
//
//  Created by de Oliveira, Rafael on 28/04/22.
//

import Moya

extension Response {
    /// Maps data received from the signal into a Decodable object.
    ///
    /// - parameter atKeyPath: Optional key path at which to parse object.
    /// - parameter using: A `JSONDecoder` instance which is used to decode data to an object.
    func decode<D: Decodable>(_ type: D.Type, using decoder: JSONDecoder = AppSettings.jsonDecoder) throws -> D {
        return try map(type, using: decoder)
    }
}
