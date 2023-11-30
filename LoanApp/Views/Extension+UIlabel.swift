//
//  Extension+UIlabel.swift
//  LoanApp
//
//  Created by Дмитрий Пономарев on 30.11.2023.
//

import UIKit

extension UILabel {
    func makespecifiedLabelInStack(text: String, textAllignment: NSTextAlignment = .left) {
        self.text = text
        self.font = .systemFont(ofSize: 50, weight: .black)
        self.textAlignment = .right
        self.textColor = .white
        self.minimumScaleFactor = 0.5
        self.adjustsFontSizeToFitWidth = true
    }
}
