//
//  Service.swift
//  MVVM
//
//  Created by de Oliveira, Rafael on 27/04/22.
//

import Foundation

protocol Service {
    typealias Completion<T> = (_ result: Result<T, Error>) -> ()
}
