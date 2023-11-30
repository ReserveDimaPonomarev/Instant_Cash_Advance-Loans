//
//  CustomButtonOnHalfView.swift
//  LoanApp
//
//  Created by Дмитрий Пономарев on 01.12.2023.
//

import UIKit

class CustomButtonOnHalfView: UIButton {
    
    
    func setupButton(title: String) {
        self.setTitle(title, for: .normal)
        self.setTitleColor(.white, for: .normal)
        self.titleLabel?.font = .systemFont(ofSize: 30, weight: .black)
        self.titleLabel?.textAlignment = .center
    }
}
