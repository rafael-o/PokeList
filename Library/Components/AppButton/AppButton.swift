//
//  AppButton.swift
//  MVVM
//
//  Created by de Oliveira, Rafael on 05/05/22.
//

import UIKit

enum AppButtonColor {
    case green
    case white
    case red
}

class AppButton: UIButton {
    
    private var buttonColor: AppButtonColor = .green
    
    override var isEnabled: Bool {
        didSet {
            isUserInteractionEnabled = isEnabled
            let value = isEnabled ? 1.0 : 0.5
            backgroundColor = backgroundColor?.withAlphaComponent(value)
            layer.borderColor = getBorderColor(with: buttonColor).withAlphaComponent(value).cgColor
        }
    }
    
    convenience init(title: String, color: AppButtonColor = .green) {
        self.init()
        
        setTitle(title, for: .normal)
        setTitleColor(getTitleColor(with: color), for: .normal)
        setTitleColor(getTitleColor(with: color).withAlphaComponent(0.5), for: .disabled)
        titleLabel?.font = AppFonts.exo2(type: .semibold, with: 17)
        
        layer.cornerRadius = 10
        layer.borderColor = getBorderColor(with: color).cgColor
        layer.borderWidth = 1
        
        backgroundColor = getBackgroundColor(with: color)
        self.buttonColor = color
    }

    private func getTitleColor(with color: AppButtonColor) -> UIColor {
        switch color {
        case .green:
            return UIColor.white
        case .white:
            return AppColors.green
        case .red:
            return UIColor.red
        }
    }
    
    private func getBackgroundColor(with color: AppButtonColor) -> UIColor {
        switch color {
        case .green:
            return AppColors.green
        case .white, .red:
            return UIColor.white
        }
    }
    
    private func getBorderColor(with color: AppButtonColor) -> UIColor {
        switch color {
        case .white, .green:
            return AppColors.green
        case .red:
            return UIColor.red
        }
    }
}
