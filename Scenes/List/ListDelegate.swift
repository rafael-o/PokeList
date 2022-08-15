//
//  ListDelegate.swift
//  MVVM
//
//  Created by de Oliveira, Rafael on 25/04/22.
//

import Foundation

protocol ListViewDelegate: AnyObject {
    func didSelectedCell(_ indexPath: IndexPath)
}

protocol ListViewModelDelegate: AnyObject {
    func requestFetchListSuccess(listResult: PokeListResponse)
    func requestFetchListFailure(with error: String)
}
