//
//  ListViewController.swift
//  MVVM
//
//  Created by de Oliveira, Rafael on 25/04/22.
//

import UIKit

class ListViewController: UIViewController {

    private lazy var mainView = ListView(delegate: self)
    private let viewModel: ListViewModel
    private let loadingView = LoadingView()
    
    private var list = [PokeResume]()
    
    override func loadView() {
        super.loadView()
        view = mainView
    }
    
    init(viewModel: ListViewModel = .init()) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
        self.mainView.delegate = self
        self.viewModel.delegate = self
        setupNavigationBar()
    }
    
    required init?(coder: NSCoder) {
        self.viewModel = ListViewModel()
        super.init(coder: coder)
        setupNavigationBar()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.loadingView.startAnimating()
        self.viewModel.fetchList()
    }
}

// MARK: - View Delegate
extension ListViewController: ListViewDelegate {
    
    func didSelectedCell(_ indexPath: IndexPath) {
        guard !list.isEmpty else { return }
        let details = DetailsViewController(poke: list[indexPath.row].poke)
        self.navigationController?.pushViewController(details, animated: true)
    }
}

// MARK: - View Model Delegate
extension ListViewController: ListViewModelDelegate {
    
    func requestFetchListSuccess(listResult: PokeListResponse) {
        self.loadingView.stopAnimating()
        self.list = listResult.pokemon
        self.mainView.configTableView(list: listResult.pokemon)
    }
    
    func requestFetchListFailure(with error: String) {
        self.showErrorModal(error: error, tag: 1)
    }
}

// MARK: - Alert Modal Delegate
extension ListViewController: AlertModalDelegate {
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
extension ListViewController {
    
    @objc private func backAction() {
        self.dismiss(animated: true)
    }
    
    @objc private func infoAction() {
        let attributedString = NSAttributedString(string: "App in development ...", attributes: AppStyles.attributeInfoGray)
        let modal = AlertModalViewController(title: "1ª Gen List", info: attributedString, nextButtonTitle: "OK", cancelButtonTitle: nil)
        self.present(modal, animated: true, completion: nil)
    }
}

// MARK: - Layout
extension ListViewController {
    private func setupNavigationBar() {
        self.title = "1ª Gen List"
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: AppImages.infoIcon, style: .plain, target: self, action: #selector(infoAction))
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
