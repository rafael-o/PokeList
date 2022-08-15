//
//  ListView.swift
//  MVVM
//
//  Created by de Oliveira, Rafael on 25/04/22.
//

import UIKit
import SnapKit

class ListView: UIView {
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.backgroundColor = .clear
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
        return tableView
    }()
    
    private var list = [PokeResume]()
    
    weak var delegate: ListViewDelegate?
    
    convenience init(delegate: ListViewDelegate) {
        self.init()
        self.delegate = delegate
        setupLayout()
    }
    
    func configTableView(list: [PokeResume]) {
        self.list = list
        tableView.reloadData()
    }
}

// MARK: - Table view Delegate
extension ListView: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return list.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell") ?? UITableViewCell()
        cell.textLabel?.text = list[indexPath.row].poke
        cell.selectionStyle = .none
        cell.backgroundColor = AppColors.lightGreen
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.delegate?.didSelectedCell(indexPath)
    }
}

// MARK: - Layout
extension ListView {
    private func setupLayout() {
        self.tintColor = AppColors.coldPurple
        self.backgroundColor = AppColors.lightGreen
        
        addTableView()
    }
    
    private func addTableView() {
        self.addSubview(tableView)
        
        tableView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
}
