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
            make.top.left.equalToSuperview().inset(10)
        }
        titleOnBlueViewLabel.snp.makeConstraints { make in
            make.left.equalTo(numberOnBlueViewLabel.snp.right).offset(10)
            make.right.equalToSuperview().inset(16)
            make.top.equalTo(numberOnBlueViewLabel).offset(16)
        }
        subtitleOnBlueViewLabel.snp.makeConstraints { make in
            make.left.right.equalTo(titleOnBlueViewLabel)
            make.top.equalTo(titleOnBlueViewLabel.snp.bottom).offset(8)
        }
    }
    
    private func setupSubViews() {

    }
    
    func setupTextInsideView(number: Int, title: String, subtitle: String) {
        numberOnBlueViewLabel.text = "\(number)"

        numberOnBlueViewLabel.textColor = .white
        numberOnBlueViewLabel.font = .systemFont(ofSize: 80, weight: .black)
        numberOnBlueViewLabel.setContentCompressionResistancePriority(.defaultHigh, for: .horizontal)
        titleOnBlueViewLabel.setContentHuggingPriority(.defaultLow, for: .horizontal)
        titleOnBlueViewLabel.text = title
        titleOnBlueViewLabel.minimumScaleFactor = 0.5
        titleOnBlueViewLabel.adjustsFontSizeToFitWidth = true
        titleOnBlueViewLabel.textColor = .white
        titleOnBlueViewLabel.font = .systemFont(ofSize: 24, weight: .black)
        subtitleOnBlueViewLabel.text = subtitle
        subtitleOnBlueViewLabel.minimumScaleFactor = 0.5
        subtitleOnBlueViewLabel.adjustsFontSizeToFitWidth = true
        subtitleOnBlueViewLabel.textColor = .white
        subtitleOnBlueViewLabel.numberOfLines = 0
        subtitleOnBlueViewLabel.font = .systemFont(ofSize: 16, weight: .regular)
        

    }
}
