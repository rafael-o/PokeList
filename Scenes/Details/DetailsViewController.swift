//
//  DetailsViewController.swift
//  MVVM
//
//  Created by de Oliveira, Rafael on 18/05/22.
//

import UIKit

class DetailsViewController: UIViewController {

    private var mainView: DetailsView!
    private let viewModel: DetailsViewModel
    private let loadingView = LoadingView()
    
    private var poke = ""
    
    override func loadView() {
        super.loadView()
        view = mainView
    }
    
    init(viewModel: DetailsViewModel = .init(), poke: String) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
        self.viewModel.delegate = self
        self.mainView = DetailsView(poke: poke)
        self.poke = poke
        setupNavigationBar()
    }
    
    required init?(coder: NSCoder) {
        self.viewModel = DetailsViewModel()
        super.init(coder: coder)
        self.mainView = DetailsView(poke: "")
        setupNavigationBar()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.loadingView.startAnimating()
        self.viewModel.fetchDetails(poke: self.poke)
    }
}

// MARK: - View Model Delegate
extension DetailsViewController: DetailsViewModelDelegate {
    func requestFetchDetailsSuccess(detailsResult: PokeDetailsResponse) {
        self.loadingView.stopAnimating()
        self.mainView.configView(details: detailsResult)
    }
    
    func requestFetchDetailsFailure(with error: String) {
        self.loadingView.stopAnimating()
        self.showErrorModal(error: error, tag: 1)
    }
}

// MARK: - Alert Modal Delegate
extension DetailsViewController: AlertModalDelegate {
    func nextAction(alert: AlertModalViewController) {
        switch alert.tag {
        case 1:
            self.backAction()
        default:
            break
        }
    }
}

// MARK: - Actions
extension DetailsViewController {
    @objc private func backAction() {
        self.navigationController?.popViewController(animated: true)
    }
}

// MARK: - Layout
extension DetailsViewController {
    private func setupNavigationBar() {
        self.title = "Poke Details"
        navigationController?.navigationBar.prefersLargeTitles = false
    }
    
    private func showErrorModal(error: String, tag: Int) {
        let attributedString = NSAttributedString(string: error, attributes: AppStyles.attributeInfoGray)
        let modal = AlertModalViewController(title: "Atenção", info: attributedString, nextButtonTitle: "OK", cancelButtonTitle: nil)
        modal.delegate = self
        modal.tag = tag
        self.present(modal, animated: true, completion: nil)
    }
}
