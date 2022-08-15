//
//  DetailsView.swift
//  MVVM
//
//  Created by de Oliveira, Rafael on 18/05/22.
//

import UIKit
import SnapKit
import Kingfisher

class DetailsView: UIView {

    private let stackView: ScrollableStackView = {
        let stack = ScrollableStackView()
        stack.scrollView.showsVerticalScrollIndicator = false
        stack.stackView.spacing = 0
        stack.scrollView.contentInset = .zero
        return stack
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = AppFonts.exo2(type: .semibold, with: 24)
        label.textColor = AppColors.green
        label.textAlignment = .center
        return label
    }()
    
    private let spriteImage = UIImageView(image: AppImages.placeholderImage)
    
    private let shinyImage = UIImageView(image: AppImages.placeholderImage)
    
    private let typeTitleLabel: UILabel = {
        let label = UILabel()
        label.font = AppFonts.exo2(type: .semibold, with: 16)
        label.text = "Type:"
        return label
    }()
    
    private let typeLabel: UILabel = {
        let label = UILabel()
        label.font = AppFonts.exo2(with: 16)
        return label
    }()
    
    private let abilityTitleLabel: UILabel = {
        let label = UILabel()
        label.font = AppFonts.exo2(type: .semibold, with: 16)
        label.text = "Ability:"
        return label
    }()
    
    private let abilityLabel: UILabel = {
        let label = UILabel()
        label.font = AppFonts.exo2(with: 16)
        return label
    }()
    
    convenience init(poke: String) {
        self.init()
        titleLabel.text = poke.capitalized
        setupLayout()
    }
}

//MARK: - Layout
extension DetailsView {
    private func setupLayout() {
        self.tintColor = AppColors.coldPurple
        self.backgroundColor = AppColors.lightGreen
        
        addScrollbleStackView()
        addHeader()
        addSprites()
        addType()
        addAbility()
    }
    
    public func configView(details: PokeDetailsResponse) {
        if let spriteUrl = URL(string: details.images.front_default) {
            spriteImage.kf.setImage(with: spriteUrl)
        }
        if let shinyUrl = URL(string: details.images.front_shiny) {
            shinyImage.kf.setImage(with: shinyUrl)
        }
        typeLabel.text = details.types.sorted { $0.slot < $1.slot }.compactMap({ return $0.type.name }).joined(separator: "/")
        abilityLabel.text = details.abilities.compactMap({ return $0.isHidden ? "(Hidden)" + $0.ability.name : $0.ability.name }).joined(separator: ", ")
    }
    
    private func addScrollbleStackView() {
        self.addSubview(stackView)
        stackView.snp.makeConstraints {
            $0.top.bottom.leading.trailing.equalToSuperview()
        }
    }
    
    private func addDivider() {
        let separator = UIView()
        separator.backgroundColor = AppColors.gray
        separator.snp.makeConstraints {
            $0.height.equalTo(0.5)
        }
        stackView.addArrangedSubview(separator)
    }
    
    private func addHeader() {
        let view = UIView()
        view.addSubview(titleLabel)
        
        titleLabel.snp.makeConstraints {
            $0.top.bottom.equalToSuperview().inset(10)
            $0.leading.trailing.equalToSuperview().inset(20)
        }
        stackView.addArrangedSubview(view)
        addDivider()
    }
    
    private func addSprites() {
        let view = UIView()
        view.addSubview(spriteImage)
        view.addSubview(shinyImage)
        
        spriteImage.snp.makeConstraints {
            $0.width.equalToSuperview().multipliedBy(0.36)
            $0.height.equalTo(spriteImage.snp.width)
            $0.top.bottom.equalToSuperview().inset(20)
            $0.trailing.equalTo(view.snp.centerX).offset(-10)
        }
        
        shinyImage.snp.makeConstraints {
            $0.size.equalTo(spriteImage.snp.size)
            $0.centerY.equalTo(spriteImage.snp.centerY)
            $0.leading.equalTo(view.snp.centerX).offset(10)
        }
        stackView.addArrangedSubview(view)
        addDivider()
    }
    
    private func addType() {
        let view = UIView()
        view.addSubview(typeTitleLabel)
        view.addSubview(typeLabel)
        
        typeTitleLabel.snp.makeConstraints {
            $0.top.equalToSuperview().inset(10)
            $0.leading.trailing.equalToSuperview().inset(20)
        }
        
        typeLabel.snp.makeConstraints {
            $0.top.equalTo(typeTitleLabel.snp.bottom).offset(8)
            $0.leading.trailing.equalToSuperview().inset(20)
            $0.bottom.equalToSuperview().inset(10)
        }
        
        stackView.addArrangedSubview(view)
        addDivider()
    }
    
    private func addAbility() {
        let view = UIView()
        view.addSubview(abilityTitleLabel)
        view.addSubview(abilityLabel)
        
        abilityTitleLabel.snp.makeConstraints {
            $0.top.equalToSuperview().inset(10)
            $0.leading.trailing.equalToSuperview().inset(20)
        }
        
        abilityLabel.snp.makeConstraints {
            $0.top.equalTo(abilityTitleLabel.snp.bottom).offset(8)
            $0.leading.trailing.equalToSuperview().inset(20)
            $0.bottom.equalToSuperview().inset(10)
        }
        
        stackView.addArrangedSubview(view)
        addDivider()
    }
}
