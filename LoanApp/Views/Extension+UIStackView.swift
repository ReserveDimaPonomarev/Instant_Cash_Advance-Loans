//
//  Extension+UIStackView1.swift
//  LoanApp
//
//  Created by Дмитрий Пономарев on 30.11.2023.
//

import UIKit

extension UIStackView {
    func makeCustomStackView(alignment: UIStackView.Alignment) {
        self.axis = .vertical
        self.alignment = alignment
        self.spacing = 5
        self.distribution = .fillProportionally
    }
}
