//
//  PokeService.swift
//  MVVM
//
//  Created by de Oliveira, Rafael on 27/04/22.
//

import Foundation

class PokeService: Service {
    
    private let provider: AppProvider<PokeTarget>

    init(provider: AppProvider<PokeTarget>) {
        self.provider = provider
    }

    convenience init() {
        self.init(provider: .init())
    }
    
    func fetchPokeList(request: PokeListRequest, completion: @escaping Completion<PokeListResponse>) {
        provider.request(.getList(parameters: request.asParams()))
            .map { try $0.decode(PokeListResponse.self) }
            .resolve(completion)
    }
    
    func fetchPokeDetails(name: String, completion: @escaping Completion<PokeDetailsResponse>) {
        provider.request(.getDetails(name: name))
            .map { try $0.decode(PokeDetailsResponse.self) }
            .resolve(completion)
    }
}
