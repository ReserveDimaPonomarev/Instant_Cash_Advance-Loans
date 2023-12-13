//
//  сгыещьViewController.swift
//  LoanApp
//
//  Created by Дмитрий Пономарев on 01.12.2023.
//

import UIKit


class HalfViewController: UIViewController {
    
    //  MARK: - UI properties
    
    private let closeButton = UIButton()
    private let privacyPolicyLabel = CustomButtonOnHalfView()
    private let termsOfUseLabel = CustomButtonOnHalfView()
    private let loanTermsLabel = CustomButtonOnHalfView()
    
    //  MARK: - life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        addViews()
        setupSubViews()
        makeConstraints()
    }
}

//  MARK: - private methods

private extension HalfViewController {
    
    func addViews() {
        view.addSubview(closeButton)
        view.addSubview(privacyPolicyLabel)
        view.addSubview(termsOfUseLabel)
        view.addSubview(loanTermsLabel)
    }
    
    func setupView() {

        view.backgroundColor = .blue
        let cornerRadius: CGFloat = 60
        view.layer.cornerRadius = cornerRadius
        view.layer.maskedCorners = [.layerMinXMinYCorner, .layerMinXMaxYCorner]
        view.clipsToBounds = true
    }
    
    func makeConstraints() {
        closeButton.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide)
            make.right.equalToSuperview().inset(20)
            make.size.equalTo(50)
        }
        privacyPolicyLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(300)
            make.height.equalTo(privacyPolicyLabel.titleLabel?.intrinsicContentSize.height ?? 0)
            make.right.equalToSuperview().inset(20)
        }
        termsOfUseLabel.snp.makeConstraints { make in
            make.top.equalTo(privacyPolicyLabel.snp.bottom).offset(40)
            make.height.equalTo(termsOfUseLabel.titleLabel?.intrinsicContentSize.height ?? 0)
            make.right.equalToSuperview().inset(20)
        }
        loanTermsLabel.snp.makeConstraints { make in
            make.top.equalTo(termsOfUseLabel.snp.bottom).offset(40)
            make.height.equalTo(loanTermsLabel.titleLabel?.intrinsicContentSize.height ?? 0)
            make.right.equalToSuperview().inset(20)
        }
    }
    
    func setupSubViews() {
        
        closeButton.setImage(.closeMenu, for: .normal)
        closeButton.addTarget(self, action: #selector(onCloseMenuTapped), for: .touchUpInside)
        
        privacyPolicyLabel.setupButton(title: "Privacy Policy")
        privacyPolicyLabel.addTarget(self, action: #selector(showPrivacyPolicyPage), for: .touchUpInside)
        
        termsOfUseLabel.setupButton(title: "Terms Of Use")
        termsOfUseLabel.addTarget(self, action: #selector(showTermsOfUsePage), for: .touchUpInside)
        
        loanTermsLabel.setupButton(title: "Loan Terms")
        loanTermsLabel.addTarget(self, action: #selector(showLoanTermsPage), for: .touchUpInside)
        loanTermsLabel.titleLabel?.numberOfLines = 2
    }
    
    //  MARK: - @objc func

    @objc func onCloseMenuTapped() {
        UIView.animate(withDuration: 0.5, delay: 0, options: .curveEaseIn) { [weak self] in
            guard let self else { return }
            view.frame = CGRect(x: UIScreen.main.bounds.width, y: 0, width: 0, height: UIScreen.main.bounds.height)
        }
    }
    
    @objc func showPrivacyPolicyPage() {
        let vc = PrivacyPolicyPageViewController()
        navigationController?.present(vc, animated: true)
   }
    
    @objc func showLoanTermsPage() {
        let vc = LoanTermsPageViewController()
        navigationController?.present(vc, animated: true)
   }
    
    @objc func showTermsOfUsePage() {
        let vc = TermsOfUsePageViewController()
        navigationController?.present(vc, animated: true)
   }
}
