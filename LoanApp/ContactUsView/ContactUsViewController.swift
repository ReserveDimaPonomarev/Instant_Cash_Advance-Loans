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
    
    private let contactLabel = CustomTitleLabel()
    private let subtitleContactLabel = CustomSubTitleLabel()
    private let nameTextField = CusomTextFieldWithBorder()
    private let messageTextView = CustomTextViewWithBorder()
    private let buttonSend = CustomButton()
    
    //  MARK: - life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        view.backgroundColor = .blue
    }
}

//  MARK: - private methods

private extension ContactUsViewController {
    
    //  MARK: - setup UI
    
    func setup() {
        addViews()
        setupViews()
        setupConstraints()
        addActions()
    }
    
    func addViews() {
        view.addSubview(contactLabel)
        view.addSubview(subtitleContactLabel)
        view.addSubview(nameTextField)
        view.addSubview(messageTextView)
        view.addSubview(buttonSend)
    }
    
    func setupViews() {
        contactLabel.setupCustomTitleLabel(text: "Contact", textColor: .white)
        subtitleContactLabel.setupCustomSubTitleLabel(text: "Please feel free to contact us with any queries or ideas you have!\nWe are always happy to be of assistance.", textColor: .white, alignment: .center)
        
        nameTextField.setupTextField(placeholder: "Name", backgroundColor: .blue, borderColor: .white, placehplderColor: .white, textColor: .white, borderWidth: 8)
        
        messageTextView.setupTextView(placeholder: "Message")
        
        buttonSend.setupView(title: "Send", color: .white, titleColor: .blue)
        buttonSend.addTarget(self, action: #selector(onSendButtonTapped), for: .touchUpInside)
        endEditingFromClosures()
    }
    
    func setupConstraints() {
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
    
    //  MARK: - addActions
    
    func addActions() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    func endEditingFromClosures() {
        nameTextField.closure = { [weak self] in
            guard let self else { return }
            self.view.endEditing(true)
        }
        messageTextView.closure = { [weak self] in
            guard let self else { return }
            self.view.endEditing(true)
        }
    }
    
    //  MARK: - private methods
    
    func findActiveField() -> UIView? {
        if nameTextField.isFirstResponder {
            return nameTextField
        } else if messageTextView.isFirstResponder {
            return messageTextView
        }
        return nil
    }
    
    func configureMailComposer() -> MFMailComposeViewController{
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
    
    @objc func keyboardWillShow(notification: NSNotification) {
        if let activeField = findActiveField(),
           let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
            let buttonFrameInWindow = activeField.convert(activeField.bounds, to: nil)
            let bottomOfButton = buttonFrameInWindow.maxY
            let offset = bottomOfButton + 50 - (self.view.frame.size.height - keyboardSize.height)
            if offset > 0 {
                self.view.frame.origin.y -= offset
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

//  MARK: - extension MFMailComposeViewControllerDelegate

extension ContactUsViewController: MFMailComposeViewControllerDelegate {
    
    func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
        self.dismiss(animated: true)
    }
}

