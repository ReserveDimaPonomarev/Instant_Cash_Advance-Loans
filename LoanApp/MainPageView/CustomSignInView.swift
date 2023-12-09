//
//  CustomSignInView.swift
//  LoanApp
//
//  Created by Дмитрий Пономарев on 08.12.2023.
//

import UIKit

class CustomSignInView: UIView {
    
    private let signInImageView = UIImageView()
    private let signInLabel = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addViews()
        setupViews()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func addViews() {
        self.addSubview(signInImageView)
        self.addSubview(signInLabel)
    }
    
    func setupViews() {
        self.layer.cornerRadius = 25
        self.clipsToBounds = true
        self.layer.borderColor = UIColor.blue.cgColor
        self.layer.borderWidth = 4
        
        signInImageView.image = UIImage(resource: .accountPageIcon)
        signInImageView.contentMode = .scaleAspectFit
        signInLabel.text = "Sign In"
        signInLabel.textColor = .blue
        signInLabel.font = .systemFont(ofSize: 30, weight: .heavy)
    }
    
    func setupConstraints() {
        signInImageView.snp.makeConstraints { make in
            make.left.top.bottom.equalToSuperview().inset(10)
            make.size.equalTo(30)
        }
        signInLabel.snp.makeConstraints { make in
            make.left.equalTo(signInImageView.snp.right).offset(5)
            make.top.bottom.right.equalToSuperview().inset(10)
        }
        
    }
}
