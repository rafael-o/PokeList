//
//  AlertModalView.swift
//  MVVM
//
//  Created by de Oliveira, Rafael on 05/05/22.
//

import UIKit
import SnapKit

class AlertModalView: UIView {

    private let modalView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        return view
    }()
    
    private let appendView: UIView = {
        let appendView: UIView = UIView()
        appendView.backgroundColor = .white
        appendView.layer.cornerRadius = 8
        return appendView
    }()
    
    private let headerView: UIView = UIView()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.font = AppFonts.exo2(type: .bold, with: 22)
        label.numberOfLines = 0
        return label
    }()
    
    private let infoView: UIView = UIView()
    
    private let infoLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        return label
    }()
    
    private lazy var nextButton: AppButton = {
        let button = AppButton(title: "Continuar", color: .green)
        button.addTarget(self, action: #selector(nextButtonDidTapped), for: .touchUpInside)
        return button
    }()
    
    private lazy var cancelButton: AppButton = {
        let button = AppButton(title: "Cancelar", color: .white)
        button.addTarget(self, action: #selector(cancelButtonDidTapped), for: .touchUpInside)
        return button
    }()
    
    private var hasInfo = false
    private var hasCancelButton = false
    
    public weak var delegate: AlertModalViewDelegate?
    
    convenience init(title: String, info: NSAttributedString?, nextButtonTitle: String, cancelButtonTitle: String?, redButton: Bool = false) {
        self.init()
        setupComponents(title: title, info: info, nextButtonTitle: nextButtonTitle, cancelButtonTitle: cancelButtonTitle, redButton: redButton)
        setupLayout()
    }
}

//MARK: - Layout
extension AlertModalView {
    
    private func setupComponents(title: String, info: NSAttributedString?, nextButtonTitle: String, cancelButtonTitle: String?, redButton: Bool = false) {
        
        titleLabel.text = title
        if let info = info {
            hasInfo = true
            infoLabel.attributedText = info
        }
        if redButton {
            nextButton = AppButton(title: "", color: .red)
            nextButton.addTarget(self, action: #selector(nextButtonDidTapped), for: .touchUpInside)
            cancelButton = AppButton(title: "", color: .green)
            cancelButton.addTarget(self, action: #selector(cancelButtonDidTapped), for: .touchUpInside)
        }
        nextButton.setTitle(nextButtonTitle, for: .normal)
        if let cancelTitle = cancelButtonTitle {
            hasCancelButton = true
            cancelButton.setTitle(cancelTitle, for: .normal)
        }
    }
    
    private func setupLayout() {
        self.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(dismissOnScreenTouch)))
        self.backgroundColor = AppColors.bgBlack
        
        addModalView()
        addHeader()
        addInfo()
        addButtons()
    }
    
    private func createDivider() -> UIView {
        let separator = UIView()
        separator.backgroundColor = AppColors.gray
        separator.snp.makeConstraints {
            $0.height.equalTo(0.5)
        }
        return separator
    }
    
    private func addModalView() {
        self.addSubview(appendView)
        self.addSubview(modalView)
        
        modalView.snp.makeConstraints {
            $0.top.equalTo(self.snp.bottom)
            $0.leading.trailing.equalToSuperview()
        }
        
        appendView.snp.makeConstraints {
            $0.height.equalTo(24)
            $0.centerY.equalTo(modalView.snp_top)
            $0.leading.trailing.equalToSuperview()
        }
    }
    
    private func addHeader() {
        let separator = createDivider()
        modalView.addSubview(headerView)
        headerView.addSubview(titleLabel)
        headerView.addSubview(separator)
        
        headerView.snp.makeConstraints {
            $0.top.leading.trailing.equalToSuperview()
        }
        
        titleLabel.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview().inset(16)
            $0.top.bottom.equalToSuperview().inset(10)
        }
        
        separator.snp.makeConstraints {
            $0.bottom.trailing.equalToSuperview()
            $0.leading.equalToSuperview().inset(16)
        }
    }
    
    private func addInfo() {
        guard hasInfo else { return }
        
        modalView.addSubview(infoView)
        infoView.addSubview(infoLabel)
        
        infoView.snp.makeConstraints {
            $0.top.equalTo(headerView.snp.bottom).offset(10)
            $0.leading.trailing.equalToSuperview()
        }
        
        infoLabel.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview().inset(16)
            $0.top.bottom.equalToSuperview().inset(10)
        }
    }
    
    private func addButtons() {
        modalView.addSubview(nextButton)
        
        nextButton.snp.makeConstraints {
            $0.top.equalTo(hasInfo ? infoView.snp.bottom : headerView.snp.bottom).offset(16)
            $0.leading.trailing.equalToSuperview().inset(16)
            $0.height.equalTo(50)
            if !hasCancelButton {
                $0.bottom.equalToSuperview().inset(16)
            }
        }
        
        guard hasCancelButton else { return }
        
        modalView.addSubview(cancelButton)
        
        cancelButton.snp.makeConstraints {
            $0.top.equalTo(nextButton.snp.bottom).offset(16)
            $0.bottom.leading.trailing.equalToSuperview().inset(16)
            $0.height.equalTo(50)
        }
    }
}

// MARK: - @OBJC Functions
extension AlertModalView {
    
    @objc private func nextButtonDidTapped(_ sender: UIButton) {
        self.animationToDismiss {
            self.delegate?.nextButtonDidTap()
        }
    }
    
    @objc private func cancelButtonDidTapped(_ sender: UIButton) {
        self.animationToDismiss {
            self.delegate?.cancelButtonDidTap()
        }
    }
    
    @objc private func dismissOnScreenTouch() {
        self.animationToDismiss {
            self.delegate?.cancelButtonDidTap()
        }
    }
}

//MARK: - Animation
extension AlertModalView {
    
    public func animationToShow() {
        self.layoutIfNeeded()
        self.modalView.snp.remakeConstraints {
            $0.top.greaterThanOrEqualTo(40)
            $0.leading.trailing.equalToSuperview()
            $0.bottom.equalTo(self.snp.bottomMargin)
        }

        UIView.animate(withDuration: 0.3, delay: 0.0, options: [.curveEaseInOut]) {
            self.layoutIfNeeded()
        }
    }
    
    private func animationToDismiss(completion: @escaping (() -> Void)) {
        self.modalView.snp.remakeConstraints {
            $0.leading.trailing.equalToSuperview()
            $0.top.equalTo(self.snp.bottom)
        }
        UIView.animate(withDuration: 0.3, delay: 0.0, options: [.curveEaseInOut]) {
            self.layoutIfNeeded()
        } completion: { _ in
            completion()
        }
    }
}
