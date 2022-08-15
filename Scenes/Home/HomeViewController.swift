//
//  HomeViewController.swift
//  MVVM
//
//  Created by de Oliveira, Rafael on 22/04/22.
//

import UIKit

class HomeViewController: UIViewController {

    private lazy var mainView = HomeView(delegate: self)
    
    override func loadView() {
        super.loadView()
        self.view = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}

// MARK: - View Delegate
extension HomeViewController: HomeViewDelegate {
    func viewDidTap() {
        let controller = ListViewController()
        let nav = UINavigationController(navigationBarClass: AppNavigationBar.self, toolbarClass: nil)
        nav.viewControllers = [controller]
        nav.modalPresentationStyle = .overFullScreen
        self.present(nav, animated: true)
    }
}
