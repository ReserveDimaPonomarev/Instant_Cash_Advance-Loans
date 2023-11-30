//
//  BlueViewForHowITWorks.swift
//  LoanApp
//
//  Created by Дмитрий Пономарев on 30.11.2023.
//

import UIKit

class BlueViewForHowITWorks: UIView {
    
    let numberOnBlueViewLabel = UILabel()
    let titleOnBlueViewLabel = UILabel()
    let subtitleOnBlueViewLabel = UILabel()
    
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
        self.addSubview(numberOnBlueViewLabel)
        self.addSubview(titleOnBlueViewLabel)
        self.addSubview(subtitleOnBlueViewLabel)
    }
    
    private func setupView() {
        self.backgroundColor = .blue
        self.layer.cornerRadius = 20
        self.clipsToBounds = true
    }
    
    private func setupConstraints() {
        numberOnBlueViewLabel.snp.makeConstraints { make in
            make.top.leading.equalToSuperview().inset(10)
        }
        titleOnBlueViewLabel.snp.makeConstraints { make in
            make.leading.equalTo(numberOnBlueViewLabel.snp.trailing).offset(8)
            make.trailing.equalToSuperview().inset(16)
            make.top.equalTo(numberOnBlueViewLabel).offset(16)
        }
        subtitleOnBlueViewLabel.snp.makeConstraints { make in
            make.leading.trailing.equalTo(titleOnBlueViewLabel)
            make.top.equalTo(titleOnBlueViewLabel.snp.bottom).offset(16)
        }
    }
    
    private func setupSubViews() {
        numberOnBlueViewLabel.text = "1"
        numberOnBlueViewLabel.textColor = .white
        numberOnBlueViewLabel.font = .systemFont(ofSize: 80, weight: .black)
        titleOnBlueViewLabel.text = "Submit A Request"
        titleOnBlueViewLabel.textColor = .white
        titleOnBlueViewLabel.font = .systemFont(ofSize: 30, weight: .black)
        
        subtitleOnBlueViewLabel.text = "lololololololololololololololololololololololololololololololololololololololololololololololololololololololololololololololololololololololololololololololololololololololololoqqqqqq"
        subtitleOnBlueViewLabel.textColor = .white
        subtitleOnBlueViewLabel.numberOfLines = 0
        subtitleOnBlueViewLabel.font = .systemFont(ofSize: 20, weight: .regular)
    }
}
