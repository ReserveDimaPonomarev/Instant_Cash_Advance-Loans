//
//  CustomStackView.swift
//  LoanApp
//
//  Created by Дмитрий Пономарев on 01.12.2023.
//

import UIKit

class CustomStackView: UIStackView {
    
    private let inputtedLabel = UILabel()
    let inputtedTextField = CusomTextFieldWithBorder()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setupStackView()
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupStackView() {
        self.addArrangedSubview(inputtedLabel)
        self.addArrangedSubview(inputtedTextField)
        self.axis = .vertical
        self.spacing = 10
    }
    
    func setupSubViews(labelText: String, textFieldPlaceholder: String = "") {
        inputtedLabel.text = labelText
        inputtedLabel.textAlignment = .left
        inputtedLabel.font = .systemFont(ofSize: 24, weight: .medium)
        inputtedLabel.numberOfLines = 0
        inputtedLabel.textColor = .blue
        
        inputtedTextField.setupTextField(placeholder: textFieldPlaceholder, backgroundColor: .white, borderColor: .blue, placehplderColor: .blue, textColor: .blue, borderWidth: 4)
        inputtedTextField.snp.makeConstraints { make in
            make.height.equalTo(60)
        }
    }
}
