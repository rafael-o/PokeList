//
//  AppStyles.swift
//  MVVM
//
//  Created by de Oliveira, Rafael on 17/05/22.
//

import Foundation

class AppStyles {
    
//MARK: - Attributes Styles
    static var attributeInfoGray: [NSAttributedString.Key: Any] {
        return [NSAttributedString.Key.font : AppFonts.exo2(with: 15) as Any, NSAttributedString.Key.foregroundColor : AppColors.gray]
    }
}
