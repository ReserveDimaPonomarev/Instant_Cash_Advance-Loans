//
//  CustomBackgroundImageView.swift
//  LoanApp
//
//  Created by Дмитрий Пономарев on 30.11.2023.
//

import UIKit
class CustomBackgroundImageView: UIImageView {
    
    init() {
        super.init(image: UIImage(resource: .dollars))
        self.setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupUI() {
        self.image = UIImage(resource: .dollars)
        self.contentMode = .scaleAspectFill
        self.layer.opacity = 0.1
        self.isOpaque = true
    }
}
