//
//  CusomTextFieldWithBorder.swift
//  LoanApp
//
//  Created by Дмитрий Пономарев on 30.11.2023.
//

import UIKit

class CusomTextFieldWithBorder: UITextField {
    
    var closure: (()->Void)?
    let datePicker = UIDatePicker()
    
    func setupTextField(placeholder: String, backgroundColor: UIColor, borderColor: UIColor, placehplderColor: UIColor, textColor: UIColor, borderWidth: CGFloat) {
        self.borderStyle = .roundedRect
        self.textColor = textColor
        self.font = .systemFont(ofSize: 25, weight: .medium)
        self.backgroundColor = backgroundColor
        self.layer.cornerRadius = 28
        self.clipsToBounds = true
        self.layer.borderColor = borderColor.cgColor
        self.layer.borderWidth = borderWidth
        let placeholderAttributes: [NSAttributedString.Key: Any] = [
            .foregroundColor: placehplderColor,
            .font: UIFont.systemFont(ofSize: 25, weight: .medium)
        ]
        self.attributedPlaceholder = NSAttributedString(string: placeholder, attributes: placeholderAttributes)
        let leftPaddingView = UIView(frame: CGRect(x: 0, y: 0, width: 30, height: self.bounds.height))
        self.leftView = leftPaddingView
        self.leftViewMode = .always
        self.delegate = self
    }
    
    func createDatePicker() {
        datePicker.preferredDatePickerStyle = .wheels
        datePicker.datePickerMode = .date
        self.inputView = datePicker
        self.inputAccessoryView = createToolBar()
    }
    
    private func calculateAge(from date: Date) -> Int? {
        let calendar = Calendar.current
        let currentDate = Date()
        let components = calendar.dateComponents([.year], from: date, to: currentDate)
        return components.year
    }
    
    private func createToolBar() -> UIToolbar{
        let toolbar = UIToolbar();
        toolbar.sizeToFit()
        
        let doneButton = UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(doneВatePicker))
        toolbar.setItems([doneButton], animated: false)

        return toolbar
    }
    
    @objc private func doneВatePicker(){
        let formatter = DateFormatter()
        formatter.dateFormat = "dd MMMM yyyy"
        formatter.dateStyle = .medium
        formatter.timeStyle = .none
        let selectedDate = datePicker.date

        if let age = calculateAge(from: selectedDate), age < 18 {
            closure?()
        } else {
            self.text = formatter.string(from: selectedDate)
        }
        closure?()
    }
}

extension CusomTextFieldWithBorder: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        closure?()
        return true
    }
}
