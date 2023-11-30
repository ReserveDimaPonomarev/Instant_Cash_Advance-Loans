//
//  File.swift
//  LoanApp
//
//  Created by Дмитрий Пономарев on 01.12.2023.
//

import UIKit


final class TermsOfUsePageViewController: UIViewController {
    

    //  MARK: - UI properties
    
    let titleLabel = CustomTitleLabel()
    let descriptionTextField = CustomTextViewWithBorder()
    let buttonBack = CustomButton()
    
    //  MARK: - life Cycle

    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
    
    //  MARK: - setup UI
    
    private func setup() {
        addViews()
        setupViews()
        setupConstraints()
    }
        
    private func addViews() {
        view.addSubview(titleLabel)
        view.addSubview(descriptionTextField)
        view.addSubview(buttonBack)
    }
    
    private func setupViews() {
        view.backgroundColor = .blue
        titleLabel.setupCustomTitleLabel(text: "Terms Of Use", textColor: .white)
        descriptionTextField.setupTextView(placeholder: "Lorem ipsum dolor sit amet, consec-tetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Quis ipsum suspen-disse ultrices gravida. Risus com-modo viverra maecenas accumsan lacus vel facilisis. Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Quis ipsum suspendisse ultrices gravida./nRisus commodo viverra maecenas accumsan lacus vel facilisis. Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Quis ipsum suspen-disse ultrices gravida. Risus com-modo viverra maecenas accumsan lacus vel facilisis. Lorem ipsum dolor")
        buttonBack.setupView(title: "Back", color: .white, titleColor: .blue)
        buttonBack.addTarget(self, action: #selector(showRegistrationScreen), for: .touchUpInside)

    }
        
    private func setupConstraints() {
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
