//
//  CustomTextViewWithBorder.swift
//  LoanApp
//
//  Created by Дмитрий Пономарев on 30.11.2023.
//

import UIKit

class CustomTextViewWithBorder: UITextView {
    
    var closure: (()->Void)?
    
    func setupTextView(placeholder: String) {
        self.layer.cornerRadius = 28
        self.clipsToBounds = true
        self.layer.borderColor = UIColor.white.cgColor
        self.layer.borderWidth = 8
        self.textColor = .white
        self.font = .systemFont(ofSize: 25, weight: .medium)
        self.backgroundColor = .blue
        self.textContainerInset = UIEdgeInsets(top: 20, left: 30, bottom: 0, right: 10)
        
        let placeholderAttributes: [NSAttributedString.Key: Any] = [
            .foregroundColor: UIColor.white,
            .font: UIFont.systemFont(ofSize: 25, weight: .medium)
        ]
        self.attributedText = NSAttributedString(string: placeholder, attributes: placeholderAttributes)
        
        let leftPaddingView = UIView(frame: CGRect(x: 0, y: 0, width: 40, height: self.bounds.height))
        self.addSubview(leftPaddingView)
        
        self.textContainer.lineFragmentPadding = 0
        self.delegate = self

    }
    
    private func hidePlaceholder() {
        if self.text == "Message" {
            self.text = ""
            self.textColor = .white
        }
    }
}
    
extension CustomTextViewWithBorder: UITextViewDelegate {
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        if text != "\n" {
            hidePlaceholder()
        }
        
        if text == "\n" {
            closure?()
            return false
        }
        return true
    }
}
