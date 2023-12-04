//
//  CustomTitleLabel.swift
//  LoanApp
//
//  Created by Дмитрий Пономарев on 30.11.2023.
//

import UIKit

class CustomTitleLabel: UILabel {
    
    func setupCustomTitleLabel(text: String, textColor: UIColor) {
        self.text = text
        self.textColor = textColor
        self.font = .systemFont(ofSize: 30, weight: .black)
        self.textAlignment = .center
    }
    
    func setupCustomLabelOnMainScreen(text: String, fontSize: CGFloat, allignment: NSTextAlignment) {
        self.text = text
        self.textColor = .blue
        self.font = .systemFont(ofSize: fontSize, weight: .black)
        self.textAlignment = allignment
        self.minimumScaleFactor = 0.5
        self.adjustsFontForContentSizeCategory = true
    }

}


