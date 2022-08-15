//
//  AlertModalDelegate.swift
//  MVVM
//
//  Created by de Oliveira, Rafael on 05/05/22.
//

import Foundation

@objc protocol AlertModalDelegate: AnyObject {
    func nextAction(alert: AlertModalViewController)
    @objc optional func cancelAction(alert: AlertModalViewController)
}

protocol AlertModalViewDelegate: AnyObject {
    func nextButtonDidTap()
    func cancelButtonDidTap()
}
