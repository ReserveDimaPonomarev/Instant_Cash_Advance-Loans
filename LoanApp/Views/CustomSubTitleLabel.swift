//
//  CUstomSubTitleLabel.swift
//  LoanApp
//
//  Created by Дмитрий Пономарев on 30.11.2023.
//

import UIKit

class CustomSubTitleLabel: UILabel {
    
    func setupCustomSubTitleLabel(text: String, textColor: UIColor, alignment: NSTextAlignment) {
        self.text = text
        self.textAlignment = alignment
        self.font = .systemFont(ofSize: 24, weight: .medium)
        self.numberOfLines = 0
        self.textColor = textColor
    }
}
