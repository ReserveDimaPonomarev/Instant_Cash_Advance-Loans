//
//  CusomTextFieldWithBorder.swift
//  LoanApp
//
//  Created by Дмитрий Пономарев on 30.11.2023.
//

import UIKit

class CusomTextFieldWithBorder: UITextField {
    
    var closure: (()->Void)?
    
    func setupTextField(placeholder: String, backgroundColor: UIColor, borderColor: UIColor, placehplderColor: UIColor, textColor: UIColor, borderWidth: CGFloat) {
        self.borderStyle = .roundedRect
        self.textColor = textColor
        self.font = .systemFont(ofSize: 25, weight: .medium)
        self.backgroundColor = backgroundColor
        self.layer.cornerRadius = 28
        self.clipsToBounds = true
        self.layer.borderColor = borderColor.cgColor
        self.layer.borderWidth = borderWidth
        let placeholderAttributes: [NSAttributedString.Key: Any] = [
            .foregroundColor: placehplderColor,
            .font: UIFont.systemFont(ofSize: 25, weight: .medium)
        ]
        self.attributedPlaceholder = NSAttributedString(string: placeholder, attributes: placeholderAttributes)

        
        let leftPaddingView = UIView(frame: CGRect(x: 0, y: 0, width: 30, height: self.bounds.height))
        self.leftView = leftPaddingView
        self.leftViewMode = .always
        self.delegate = self

    }
}

extension CusomTextFieldWithBorder: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        closure?()
        return true
    }
}
