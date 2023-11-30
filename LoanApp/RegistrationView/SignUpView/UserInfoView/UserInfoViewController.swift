//
//  UserInfoViewController.swift
//  LoanApp
//
//  Created by Дмитрий Пономарев on 01.12.2023.
//


import UIKit


final class UserInfoViewController: UIViewController {
    
    //  MARK: - UI properties
    
    private let backgroundImage = UIImageView()
    private let accountIcon = UIImageView()
    private let registrationLabel = CustomTitleLabel()

    
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
        view.addSubview(backgroundImage)
        view.addSubview(accountIcon)
        view.addSubview(registrationLabel)
    }
    
    private func setupViews() {
        
    }
        
    private func setupConstraints() {
        
    }
        
    //  MARK: - private methods

    
    //  MARK: - objc method
    
}
