//
//  AlertModalViewController.swift
//  MVVM
//
//  Created by de Oliveira, Rafael on 05/05/22.
//

import UIKit

class AlertModalViewController: UIViewController {

    private var mainView: AlertModalView
    
    weak var delegate: AlertModalDelegate?
    var tag: Int = 0
    
    init(title: String, info: NSAttributedString?, nextButtonTitle: String, cancelButtonTitle: String?, redButton: Bool = false) {
        self.mainView = AlertModalView(title: title, info: info, nextButtonTitle: nextButtonTitle, cancelButtonTitle: cancelButtonTitle, redButton: redButton)
        super.init(nibName: nil, bundle: nil)
        self.modalTransitionStyle = .crossDissolve
        self.modalPresentationStyle = .overFullScreen
        self.mainView.delegate = self
    }
    
    required init?(coder: NSCoder) {
        self.mainView = AlertModalView()
        super.init(coder: coder)
    }
    
    override func loadView() {
        super.loadView()
        self.view = mainView
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
            self.mainView.animationToShow()
        }
    }
}

// MARK: - View Delegate
extension AlertModalViewController: AlertModalViewDelegate {
    func nextButtonDidTap() {
        self.dismiss(animated: true) {
            self.delegate?.nextAction(alert: self)
        }
    }
    
    func cancelButtonDidTap() {
        self.dismiss(animated: true) {
            self.delegate?.cancelAction?(alert: self)
        }
    }
}
