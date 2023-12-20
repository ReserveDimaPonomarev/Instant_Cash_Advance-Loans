//
//  SignUpViewController.swift
//  LoanApp
//
//  Created by Дмитрий Пономарев on 30.11.2023.
//

import UIKit

protocol RegistrationDisplayLogic: AnyObject {
    func setButtonColorWhen(isEnabled: Bool)
    func showRegistrationErrorWith(_ text: String)
}

final class RegistrationViewController: UIViewController {
    
    //  MARK: External dependencies
    
    var presenter: RegistrationPresenterProtocol
    
    //  MARK: - UI properties
    
    private let backgroundImage = UIImageView()
    private let accountIcon = UIImageView()
    private let registrationLabel = CustomTitleLabel()
    private let userNameTextField = CusomTextFieldWithBorder()
    private let passwordTextField = CusomTextFieldWithBorder()
    private let saveButton = CustomButton()
        
    //  MARK: - init
    
    init(presenter: RegistrationPresenterProtocol) {
        self.presenter = presenter
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //  MARK: - life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        view.backgroundColor = .white
    }
}

//  MARK: - private methods

private extension RegistrationViewController {
    
    //  MARK: - setup UI
    
    func setup() {
        addViews()
        setupViews()
        setupConstraints()
        addActions()
        endEditingFromClosures()
    }
    
    func addViews() {
        view.addSubview(backgroundImage)
        view.addSubview(accountIcon)
        view.addSubview(registrationLabel)
        view.addSubview(userNameTextField)
        view.addSubview(passwordTextField)
        view.addSubview(saveButton)
    }
    
    func setupViews() {
        backgroundImage.image = UIImage(resource: .background)
        accountIcon.image = UIImage(resource: .accountPageIcon)
        registrationLabel.setupCustomTitleLabel(text: "Registration", textColor: .blue)
        userNameTextField.setupTextField(placeholder: "new email", backgroundColor: .white, borderColor: .blue, placehplderColor: .gray, textColor: .blue, borderWidth: 4)
        userNameTextField.delegate = self
        
        passwordTextField.setupTextField(placeholder: "new password", backgroundColor: .white, borderColor: .blue, placehplderColor: .gray, textColor: .blue, borderWidth: 4)
        passwordTextField.delegate = self
        
        saveButton.setupView(title: "Save", color: .gray, titleColor: .white)
        saveButton.addTarget(self, action: #selector(onSaveButtonTapped), for: .touchUpInside)
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(keyboardWillHide))
        view.addGestureRecognizer(tapGesture)
    }
    
    func setupConstraints() {
        backgroundImage.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        registrationLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(view.safeAreaLayoutGuide).offset(24)
        }
        accountIcon.snp.makeConstraints { make in
            make.bottom.equalTo(registrationLabel).inset(8)
            make.trailing.equalTo(registrationLabel.snp.leading).inset(-10)
            make.height.equalTo(registrationLabel.intrinsicContentSize.height + 10)
            make.width.equalTo(accountIcon.snp.height)
        }
        userNameTextField.snp.makeConstraints { make in
            make.top.equalTo(registrationLabel.snp.bottom).offset(50)
            make.centerX.equalToSuperview()
            make.height.equalTo(60)
            make.leading.trailing.equalToSuperview().inset(16)
        }
        passwordTextField.snp.makeConstraints { make in
            make.top.equalTo(userNameTextField.snp.bottom).offset(20)
            make.centerX.equalToSuperview()
            make.height.equalTo(60)
            make.leading.trailing.equalToSuperview().inset(16)
        }
        saveButton.snp.makeConstraints { make in
            make.top.equalTo(passwordTextField.snp.bottom).offset(20)
            make.centerX.equalToSuperview()
            make.height.equalTo(60)
            make.width.equalTo(saveButton.intrinsicContentSize.width + 80)
        }
    }
    
    //  MARK: - addActions

    func addActions() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
//        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    func endEditingFromClosures() {
        userNameTextField.closure = { [weak self] in
            guard let self else { return }
            self.view.endEditing(true)
        }
        passwordTextField.closure = { [weak self] in
            guard let self else { return }
            self.view.endEditing(true)
        }
    }
    
    //  MARK: - objc method
    
    @objc func keyboardWillShow(notification: NSNotification) {
        if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
            let buttonFrameInWindow = saveButton.convert(saveButton.bounds, to: nil)
            let bottomOfButton = buttonFrameInWindow.maxY
            let offset = bottomOfButton + 50  - (self.view.frame.size.height - keyboardSize.height)
            if offset > 0 {
                self.view.frame.origin.y -= offset
            }
        }
    }
    
    @objc func keyboardWillHide() {
        self.view.endEditing(true)
    }
    
    @objc func onSaveButtonTapped() {
        guard let usernameText = userNameTextField.text,
              let passwordText = passwordTextField.text else { return }
        presenter.makeErrorDescriptionIfIsInvalid(usernameText, passwordText)
    }
}

//  MARK: - extension SignUpDisplayLogic

extension RegistrationViewController: RegistrationDisplayLogic {
    
    func showRegistrationErrorWith(_ text: String) {
        let alertController = UIAlertController(title: "Incorrect password", message: text, preferredStyle: .alert)
        let actionCancel = UIAlertAction(title: "No", style: .default)
        alertController.addAction(actionCancel)

        present(alertController, animated: true)
    }
    
    func setButtonColorWhen(isEnabled: Bool) {
        saveButton.backgroundColor = isEnabled ? .blue : .gray
    }
}

//  MARK: - extension UITextFieldDelegate

extension RegistrationViewController: UITextFieldDelegate {
    func textFieldDidChangeSelection(_ textField: UITextField) {
        guard let usernameText = userNameTextField.text,
              let passwordText = passwordTextField.text else { return }
        presenter.checkPaswordAndEmailOnValidation(userEmail: usernameText, userPassword: passwordText)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        userNameTextField.resignFirstResponder()
        passwordTextField.resignFirstResponder()
        return true
     }
}


