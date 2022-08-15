//
//  LoadingView.swift
//  MVVM
//
//  Created by de Oliveira, Rafael on 02/05/22.
//

import UIKit
import NVActivityIndicatorView

class LoadingView: UIView {

    var loadingColor: UIColor = AppColors.coldPurple
    var loadingBackground: UIColor = UIColor.black.withAlphaComponent(0.5)
    
    var indicator: NVActivityIndicatorView?
    
    convenience init(loadingColor: UIColor? = nil) {
        self.init()
        
        if let color = loadingColor{
            self.loadingColor = color
        }
    }
    
    private func singleLoadingIndicator() -> NVActivityIndicatorView {
        if let indicator = self.indicator {
            return indicator
        }
        let indicator = NVActivityIndicatorView(frame: CGRect(x: (self.frame.size.width/2) - 20, y: (self.frame.size.height/2) - 20, width: 40, height: 40), type: .circleStrokeSpin, color: self.loadingColor, padding: 0.0)
        self.addSubview(indicator)
        NSLayoutConstraint.activate([
            indicator.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            indicator.centerYAnchor.constraint(equalTo: self.centerYAnchor)
        ])
        indicator.translatesAutoresizingMaskIntoConstraints = false
        return indicator
    }
    
    func startAnimating() {
        guard let currentWindow = self.getCurrentWindow() else { return }
        self.backgroundColor = self.loadingBackground
        self.frame = currentWindow.bounds
        currentWindow.addSubview(self)
        self.singleLoadingIndicator().startAnimating()
    }
    
    func stopAnimating() {
        indicator?.stopAnimating()
        self.removeFromSuperview()
    }
    
    /// versão mínima = iOS 13
    private func getCurrentWindow() -> UIWindow? {
        return UIApplication
                .shared
                .connectedScenes
                .compactMap { $0 as? UIWindowScene }
                .flatMap { $0.windows }
                .first { $0.isKeyWindow }
    }
}
