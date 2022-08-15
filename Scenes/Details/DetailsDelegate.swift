//
//  DetailsDelegate.swift
//  MVVM
//
//  Created by de Oliveira, Rafael on 18/05/22.
//

import Foundation

protocol DetailsViewModelDelegate: AnyObject {
    func requestFetchDetailsSuccess(detailsResult: PokeDetailsResponse)
    func requestFetchDetailsFailure(with error: String)
}
