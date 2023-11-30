//
//  CustomButton.swift
//  LoanApp
//
//  Created by Дмитрий Пономарев on 29.11.2023.
//

import UIKit

enum CurrentPageIndicator {
    case first, second, third
}

class CustomBottomView: UIView {
    
    //  MARK: - UI properties
    
    private let firstPageImageView = CustomNumberOfPageImageView()
    private let secondPageImageView = CustomNumberOfPageImageView()
    private let thirdPageImageView = CustomNumberOfPageImageView()
    let nextPageButton = UIButton()
    private let nextLabel = UILabel()
    
    //  MARK: - init
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //  MARK: - setup UI
    
    private func setupUI() {
        addViews()
        setupSubViews()
        setupView()
        setupConstraints()
    }
    
    private func addViews() {
        self.addSubview(firstPageImageView)
        self.addSubview(secondPageImageView)
        self.addSubview(thirdPageImageView)
        self.addSubview(nextPageButton)
        self.addSubview(nextLabel)
    }
    
    private func setupView() {
        self.backgroundColor = .white
        self.layer.cornerRadius = 20
        self.layer.shadowColor = UIColor.black.cgColor
        self.layer.shadowOpacity = 0.5
        self.layer.shadowOffset = CGSize(width: 0, height: -3)
        self.layer.shadowRadius = 5
    }
    
    private func setupConstraints() {
        firstPageImageView.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.left.equalToSuperview().inset(36)
            make.size.equalTo(24)
        }
        secondPageImageView.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.left.equalTo(firstPageImageView.snp.right).offset(16)
            make.size.equalTo(24)
        }
        thirdPageImageView.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.left.equalTo(secondPageImageView.snp.right).offset(16)
            make.size.equalTo(24)
        }
        nextLabel.snp.makeConstraints { make in
            make.right.equalTo(nextPageButton.snp.left).inset(-8)
            make.centerY.equalToSuperview()
            make.top.bottom.equalToSuperview().inset(20)
        }
        nextPageButton.snp.makeConstraints { make in
            make.right.equalToSuperview().inset(32)
            make.size.equalTo(50)
            make.centerY.equalToSuperview()
        }
    }
    
    private func setupSubViews() {
        
        nextPageButton.setImage(UIImage(resource: .nextPage), for: .normal)
        nextLabel.text = "next"
        nextLabel.textColor = .blue
        nextLabel.font = .systemFont(ofSize: 40, weight: .black)
    }
    
    func setupCurrentPageNumber(_ currentPage: CurrentPageIndicator) {
        switch currentPage {
        case .first:
            firstPageImageView.makeIndicatorOfPageImageView(isCurrentPage: true)
            secondPageImageView.makeIndicatorOfPageImageView()
            thirdPageImageView.makeIndicatorOfPageImageView()
        case .second:
            firstPageImageView.makeIndicatorOfPageImageView()
            secondPageImageView.makeIndicatorOfPageImageView(isCurrentPage: true)
            thirdPageImageView.makeIndicatorOfPageImageView()
        case .third:
            firstPageImageView.makeIndicatorOfPageImageView()
            secondPageImageView.makeIndicatorOfPageImageView()
            thirdPageImageView.makeIndicatorOfPageImageView(isCurrentPage: true)
        }
    }
}
