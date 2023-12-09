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
        self.layer.cornerRadius = 28
        self.setTitleColor(titleColor, for: .normal)
        self.titleLabel?.font = UIFont.systemFont(ofSize: 30, weight: .heavy)
        makeButtonAvaible(color: color)
    }
    
    private func makeButtonAvaible(color: UIColor) {
        if !self.isEnabled {
            backgroundColor = .gray
        } else {
            backgroundColor = color
        }
    }
    
    func setupButtonWithBorder(title: String, color: UIColor, titleColor: UIColor, image: UIImage) {
        self.setTitle(title, for: .normal)
        self.backgroundColor = color
        self.setImage(image, for: .normal)
        self.layer.cornerRadius = 28
        self.layer.borderColor = UIColor.blue.cgColor
        self.layer.borderWidth = 4
        self.setTitleColor(titleColor, for: .normal)
    }
    
    func setupButtonForMainView(title: String, color: UIColor, titleColor: UIColor) {
        self.setTitle(title, for: .normal)
        self.backgroundColor = color
        self.layer.cornerRadius = 40
        self.setTitleColor(titleColor, for: .normal)
        self.titleLabel?.font = UIFont.systemFont(ofSize: 30, weight: .heavy)
    }
}
