//
//  HomeView.swift
//  MVVM
//
//  Created by de Oliveira, Rafael on 22/04/22.
//

import UIKit
import SnapKit

protocol HomeViewDelegate: AnyObject {
    func viewDidTap()
}

class HomeView: UIView {

    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = AppFonts.exo2(type: .bold, with: 52)
        label.textColor = AppColors.green
        label.text = "Poke List"
        label.textAlignment = .center
        return label
    }()
    
    private let icon: UIImageView = {
        let image = UIImageView()
        image.image = AppImages.homeIcon
        image.tintColor = AppColors.coldPurple
        image.contentMode = .scaleToFill
        return image
    }()
    
    private let infoLabel: UILabel = {
        let label = UILabel()
        label.font = AppFonts.exo2(with: 15)
        label.textColor = AppColors.green
        label.backgroundColor = .init(white: 1, alpha: 0.7)
        label.text = "Tap to load"
        label.textAlignment = .center
        label.layer.cornerRadius = 12.5
        label.clipsToBounds = true
        return label
    }()
    
    private weak var delegate: HomeViewDelegate?
    
    convenience init(delegate: HomeViewDelegate) {
        self.init()
        self.delegate = delegate
        setupLayout()
    }
}

// MARK: - @OBJC Functions
extension HomeView {
    @objc private func viewTouch() {
        self.delegate?.viewDidTap()
    }
}

// MARK: - Layout
extension HomeView {
    private func setupLayout() {
        self.tintColor = AppColors.coldPurple
        self.backgroundColor = AppColors.lightGreen
        self.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(viewTouch)))
        
        addIcon()
        addTitle()
        addInfo()
    }
    
    private func addIcon() {
        self.addSubview(icon)
        
        icon.snp.makeConstraints {
            $0.size.equalTo(60)
            $0.centerX.centerY.equalToSuperview()
        }
    }
    
    private func addTitle() {
        self.addSubview(titleLabel)
        
        titleLabel.snp.makeConstraints {
            $0.height.equalTo(60)
            $0.bottom.equalTo(icon.snp.top).offset(-60)
            $0.centerX.equalToSuperview()
        }
    }
    
    private func addInfo() {
        self.addSubview(infoLabel)
        
        infoLabel.snp.makeConstraints {
            $0.height.equalTo(25)
            $0.leading.trailing.equalToSuperview().inset(20)
            $0.bottom.equalTo(self.snp.bottomMargin).inset(45)
        }
    }
}
