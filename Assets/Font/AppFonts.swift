//
//  AppFonts.swift
//  MVVM
//
//  Created by de Oliveira, Rafael on 22/04/22.
//

import UIKit

class AppFonts {
    enum Exo2Type {
        case bold, regular, semibold
    }
    
    static func exo2(type: Exo2Type = .regular, with size: CGFloat) -> UIFont? {
        switch type {
        case .bold: return UIFont(name: "Exo2-Bold", size: size)
        case .regular: return UIFont(name: "Exo2-Regular", size: size)
        case .semibold: return UIFont(name: "Exo2-SemiBold", size: size)
        }
    }
}
