//
//  PrivacyPolicyPageViewController.swift
//  LoanApp
//
//  Created by Дмитрий Пономарев on 01.12.2023.
//

import UIKit

final class PrivacyPolicyPageViewController: UIViewController {
    
    //  MARK: - UI properties
    
    private let titleLabel = CustomTitleLabel()
    private let descriptionTextField = CustomTextViewWithBorder()
    private let buttonBack = CustomButton()
    
    //  MARK: - life Cycle

    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
}

//  MARK: - private methods

private extension PrivacyPolicyPageViewController {
    
    //  MARK: - setup UI
    
    func setup() {
        addViews()
        setupViews()
        setupConstraints()
    }
        
    func addViews() {
        view.addSubview(titleLabel)
        view.addSubview(descriptionTextField)
        view.addSubview(buttonBack)
    }
    
    func setupViews() {
        view.backgroundColor = .blue
        titleLabel.setupCustomTitleLabel(text: "Privacy Policy", textColor: .white)
        descriptionTextField.setupTextView(placeholder: .privacyPolicyText)
        buttonBack.setupView(title: "Back", color: .white, titleColor: .blue)
        buttonBack.addTarget(self, action: #selector(showRegistrationScreen), for: .touchUpInside)
        self.descriptionTextField.isEditable = false
    }
        
    func setupConstraints() {
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).offset(30)
            make.centerX.equalToSuperview()
        }
        descriptionTextField.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(20)
            make.centerX.equalToSuperview()
            make.leading.trailing.equalToSuperview().inset(16)
            make.bottom.equalTo(buttonBack.snp.top).inset(-20)
        }
        buttonBack.snp.makeConstraints { make in
            make.bottom.equalToSuperview().inset(20)
            make.centerX.equalToSuperview()
            make.height.equalTo(60)
            make.width.equalTo(200)
        }
    }
        
    //  MARK: - private methods

    
    //  MARK: - objc method
    
    @objc func showRegistrationScreen() {
        dismiss(animated: true)
    }
}
