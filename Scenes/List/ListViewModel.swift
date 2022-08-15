//
//  ListViewModel.swift
//  MVVM
//
//  Created by de Oliveira, Rafael on 25/04/22.
//

import Foundation

class ListViewModel {
    
    private let pokeService = PokeService()
    
    weak var delegate: ListViewModelDelegate?
    
    func fetchList() {
        let firstGen = PokeListRequest(limit: 151, offset: 0)
        pokeService.fetchPokeList(request: firstGen) { [weak self] (result) in
            guard let self = self else { return }
            
            switch result {
            case .success(let response):
                self.delegate?.requestFetchListSuccess(listResult: response)
            case .failure(let error):
                self.delegate?.requestFetchListFailure(with: error.localizedDescription)
            }
        }
    }
}
