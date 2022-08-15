//
//  AppNavigationBar.swift
//  MVVM
//
//  Created by de Oliveira, Rafael on 18/05/22.
//

import UIKit

class AppNavigationBar: UINavigationBar {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setup()
    }
    
    private func setup() {
        isTranslucent = false
        tintColor = .white
        barTintColor = AppColors.green
        backgroundColor = AppColors.green
        
        if #available(iOS 13.0, *) {
            let navBarAppearance = UINavigationBarAppearance()
            navBarAppearance.configureWithOpaqueBackground()
            navBarAppearance.backgroundColor = AppColors.green
            navBarAppearance.titleTextAttributes = [
                NSAttributedString.Key.foregroundColor: UIColor.white,
                NSAttributedString.Key.font: AppFonts.exo2(type: .bold, with: 20) as Any
            ]
            navBarAppearance.largeTitleTextAttributes = [
                NSAttributedString.Key.foregroundColor: UIColor.white,
                NSAttributedString.Key.font: AppFonts.exo2(type: .bold, with: 36) as Any
            ]
            standardAppearance = navBarAppearance
            scrollEdgeAppearance = navBarAppearance
        }
    }
}
