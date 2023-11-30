//
//  CustomWhiteButton.swift
//  LoanApp
//
//  Created by Дмитрий Пономарев on 30.11.2023.
//

import UIKit

class CustomButton: UIButton {
    
    func setupView(title: String, color: UIColor, titleColor: UIColor) {
        self.setTitle(title, for: .normal)
        self.backgroundColor = color
        self.layer.cornerRadius = 28
        self.setTitleColor(titleColor, for: .normal)
        self.titleLabel?.font = UIFont.systemFont(ofSize: 30, weight: .heavy)
    }
}
