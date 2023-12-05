//
//  FifthScreenViewController.swift
//  LoanApp
//
//  Created by Дмитрий Пономарев on 30.11.2023.
//


import UIKit
import MessageUI

final class ContactUsViewController: UIViewController {
    
    //  MARK: - UI properties
    
    let contactLabel = CustomTitleLabel()
    let subtitleContactLabel = CustomSubTitleLabel()
    let nameTextField = CusomTextFieldWithBorder()
    let messageTextView = CustomTextViewWithBorder()
    let buttonSend = CustomButton()
    
    
    //  MARK: - life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        view.backgroundColor = .blue
        
    }
    
    //  MARK: - setup UI
    
    private func setup() {
        addViews()
        setupViews()
        setupConstraints()
        setupKeyboardNotifications()
    }
    
    private func addViews() {
        view.addSubview(contactLabel)
        view.addSubview(subtitleContactLabel)
        view.addSubview(nameTextField)
        view.addSubview(messageTextView)
        view.addSubview(buttonSend)
    }
    
    private func setupViews() {
        contactLabel.setupCustomTitleLabel(text: "Contact", textColor: .white)
        subtitleContactLabel.setupCustomSubTitleLabel(text: "Please feel free to contact us with any queries or ideas you have!\nWe are always happy to be of assistance.", textColor: .white, alignment: .center)
        
        nameTextField.setupTextField(placeholder: "Name", backgroundColor: .blue, borderColor: .white, placehplderColor: .white, textColor: .white, borderWidth: 8)
        
        nameTextField.closure = { [weak self] in
            self?.view.endEditing(true)
        }
        messageTextView.setupTextView(placeholder: "Message")
        messageTextView.closure = { [weak self] in
            self?.view.endEditing(true)
        }
        
        buttonSend.setupView(title: "Send", color: .white, titleColor: .blue)
        buttonSend.addTarget(self, action: #selector(onSendButtonTapped), for: .touchUpInside)
    }
    
    private func setupConstraints() {
        contactLabel.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).offset(8)
            make.leading.trailing.equalToSuperview().inset(16)
            make.centerX.equalToSuperview()
        }
        subtitleContactLabel.snp.makeConstraints { make in
            make.top.equalTo(contactLabel.snp.bottom).offset(8)
            make.centerX.equalToSuperview()
            make.leading.trailing.equalToSuperview().inset(16)
        }
        nameTextField.snp.makeConstraints { make in
            make.top.equalTo(subtitleContactLabel.snp.bottom).offset(20)
            make.centerX.equalToSuperview()
            make.height.equalTo(60)
            make.leading.trailing.equalToSuperview().inset(16)
        }
        messageTextView.snp.makeConstraints { make in
            make.top.equalTo(nameTextField.snp.bottom).offset(20)
            make.centerX.equalToSuperview()
            make.leading.trailing.equalToSuperview().inset(16)
            make.bottom.equalTo(buttonSend.snp.top).inset(-20)
        }
        buttonSend.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.width.equalToSuperview().inset(16)
            make.height.equalTo(60)
            make.bottom.equalTo(view.safeAreaLayoutGuide).inset(20)
        }
    }
    
    //  MARK: - private methods
    
    private func setupKeyboardNotifications() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    private func findActiveField() -> UIView? {
        if nameTextField.isFirstResponder {
            return nameTextField
        } else if messageTextView.isFirstResponder {
            return messageTextView
        }
        return nil
    }
    
    private func configureMailComposer() -> MFMailComposeViewController{
        let mailComposeVC = MFMailComposeViewController()
        if let name = nameTextField.text, let message = messageTextView.text {
            mailComposeVC.mailComposeDelegate = self
            mailComposeVC.setToRecipients(["test@mail.ru"])
            mailComposeVC.setMessageBody("\(name)\n\n\(message)", isHTML: false)
            return mailComposeVC
        }
        return mailComposeVC
    }
    
    //  MARK: - objc method
    
    // Метод показа клавиатуры и подъёма экрана наверх
    @objc func keyboardWillShow(notification: NSNotification) {
        if let activeField = findActiveField() {
            if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
                let buttonFrameInWindow = activeField.convert(activeField.bounds, to: nil)
                let bottomOfButton = buttonFrameInWindow.maxY
                let offset = bottomOfButton + 50 - (self.view.frame.size.height - keyboardSize.height)
                if offset > 0 {
                    self.view.frame.origin.y -= offset
                }
            }
        }
    }
    
    @objc func keyboardWillHide(notification: NSNotification) {
        self.view.frame.origin.y = 0
    }
    
    @objc func onSendButtonTapped() {
        let composer = configureMailComposer()
        if MFMailComposeViewController.canSendMail() {
            self.present(composer, animated: true, completion: nil)
        }
    }
}
extension ContactUsViewController: MFMailComposeViewControllerDelegate {
    
    func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
        self.dismiss(animated: true)
    }
}

