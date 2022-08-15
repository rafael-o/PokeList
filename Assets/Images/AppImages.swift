//
//  AppImages.swift
//  MVVM
//
//  Created by de Oliveira, Rafael on 25/04/22.
//

import UIKit

fileprivate let bundle: Bundle = Bundle(for: AppImages.self)

class AppImages {
    static let homeIcon: UIImage = UIImage(named: "markIcon", in: bundle, compatibleWith: nil) ?? UIImage()
    static let infoIcon: UIImage = UIImage(named: "infoIcon", in: bundle, compatibleWith: nil) ?? UIImage()
    static let placeholderImage: UIImage = UIImage(named: "placeholderImage", in: bundle, compatibleWith: nil) ?? UIImage()
}
