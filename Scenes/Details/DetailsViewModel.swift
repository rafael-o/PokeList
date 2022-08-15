//
//  DetailsViewModel.swift
//  MVVM
//
//  Created by de Oliveira, Rafael on 18/05/22.
//

import Foundation

class DetailsViewModel {
    
    private let pokeService = PokeService()
    
    weak var delegate: DetailsViewModelDelegate?
    
    func fetchDetails(poke: String) {
        pokeService.fetchPokeDetails(name: poke) { [weak self] (result) in
            guard let self = self else { return }
            
            switch result {
            case .success(let response):
                self.delegate?.requestFetchDetailsSuccess(detailsResult: response)
            case .failure(let error):
                self.delegate?.requestFetchDetailsFailure(with: error.localizedDescription)
            }
        }
    }
}
