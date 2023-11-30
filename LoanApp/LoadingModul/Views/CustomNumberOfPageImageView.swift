//
//  File.swift
//  LoanApp
//
//  Created by Дмитрий Пономарев on 30.11.2023.
//

import UIKit

class CustomNumberOfPageImageView: UIImageView {
    
    func makeIndicatorOfPageImageView(isCurrentPage: Bool = false) {
        self.backgroundColor = isCurrentPage ? .white : .blue
        self.layer.cornerRadius = 12
        self.clipsToBounds = true
        self.layer.borderColor = UIColor.blue.cgColor
        self.layer.borderWidth = 5
    }
}
