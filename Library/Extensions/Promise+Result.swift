//
//  Promise+Result.swift
//  MVVM
//
//  Created by de Oliveira, Rafael on 27/04/22.
//

import Foundation
import PromiseKit
import Moya

extension Promise {
    func resolve(_ completion: @escaping (Swift.Result<T, Error>) -> ()) {
        self.done { result in
            completion(.success(result))
        }.catch { error in
            completion(.failure(error))
        }
    }
}

extension Promise where T: Moya.Response {
    func decode<U>(as decodable: U.Type, using decoder: JSONDecoder = AppSettings.jsonDecoder) -> Promise<U> where U: Decodable {
        return self.map{ try $0.map(decodable, using: decoder) }
    }
}
