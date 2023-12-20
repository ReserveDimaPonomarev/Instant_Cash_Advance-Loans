//
//  RegistrationViewController.swift
//  LoanApp
//
//  Created by Дмитрий Пономарев on 30.11.2023.
//


import UIKit

protocol SignInDisplayLogic: AnyObject {
    func showNonExistentUserAlert()
}

final class SignInViewController: UIViewController {
    
    //  MARK: External dependencies
    
    var presenter: SignInPresenterProtocol
    
    //  MARK: - UI properties
    
    private let backgroundImage = UIImageView()
    private let accountIcon = UIImageView()
    private let signInLabel = CustomTitleLabel()
    private let emailTextField = CusomTextFieldWithBorder()
    private let passwordTextField = CusomTextFieldWithBorder()
    private let signInButton = CustomButton()
    private let createAccountButton = CustomButton()
        
    //  MARK: - init
    
    init(presenter: SignInPresenterProtocol) {
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

private extension SignInViewController {

    //  MARK: - setup UI
    
    func setup() {
        addViews()
        setupViews()
        endEditingFromClosures()
        setupConstraints()
        addActions()
    }
        
    func addViews() {
        view.addSubview(backgroundImage)
        view.addSubview(accountIcon)
        view.addSubview(signInLabel)
        view.addSubview(emailTextField)
        view.addSubview(passwordTextField)
        view.addSubview(signInButton)
        view.addSubview(createAccountButton)
    }
    
    func setupViews() {
        backgroundImage.image = UIImage(resource: .background)
        accountIcon.image = UIImage(resource: .accountPageIcon)
        signInLabel.setupCustomTitleLabel(text: "Sign In", textColor: .blue)
        emailTextField.setupTextField(placeholder: "email", backgroundColor: .white, borderColor: .blue, placehplderColor: .gray, textColor: .blue, borderWidth: 4)
        emailTextField.delegate = self

        passwordTextField.setupTextField(placeholder: "password", backgroundColor: .white, borderColor: .blue, placehplderColor: .gray, textColor: .blue, borderWidth: 4)
        passwordTextField.delegate = self
        
        signInButton.setupView(title: "Sign In", color: .gray, titleColor: .white)
        
        createAccountButton.setupView(title: "Create account", color: .blue, titleColor: .white)
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(keyboardWillHide))
        view.addGestureRecognizer(tapGesture)
    }
        
    func setupConstraints() {
        backgroundImage.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        signInLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(view.safeAreaLayoutGuide).offset(24)
        }
        accountIcon.snp.makeConstraints { make in
            make.bottom.equalTo(signInLabel).inset(8)
            make.trailing.equalTo(signInLabel.snp.leading).inset(-10)
            make.height.equalTo(signInLabel.intrinsicContentSize.height + 10)
            make.width.equalTo(accountIcon.snp.height)
        }
        emailTextField.snp.makeConstraints { make in
            make.top.equalTo(signInLabel.snp.bottom).offset(50)
            make.centerX.equalToSuperview()
            make.height.equalTo(60)
            make.leading.trailing.equalToSuperview().inset(16)
        }
        passwordTextField.snp.makeConstraints { make in
            make.top.equalTo(emailTextField.snp.bottom).offset(20)
            make.centerX.equalToSuperview()
            make.height.equalTo(60)
            make.leading.trailing.equalToSuperview().inset(16)
        }

        signInButton.snp.makeConstraints { make in
            make.top.equalTo(passwordTextField.snp.bottom).offset(20)
            make.centerX.equalToSuperview()
            make.height.equalTo(60)
            make.width.equalTo(200)
        }
        createAccountButton.snp.makeConstraints { make in
            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom).inset(20)
            make.centerX.equalToSuperview()
            make.height.equalTo(60)
            make.width.equalTo(createAccountButton.intrinsicContentSize.width + 30)
        }
    }
    
    func showInvalidPasswordAlert() {
        let alertController = UIAlertController(title: "Invalid password. Password must contatins at least 6 symbols", message: nil, preferredStyle: .alert)
        
        let actionTryAgain = UIAlertAction(title: "Try again", style: .destructive)
        alertController.addAction(actionTryAgain)
        
        present(alertController, animated: true)
    }
    
    //  MARK: - addActions

    func addActions() {

        signInButton.addTarget(self, action: #selector(onSignInButtonTap), for: .touchUpInside)
        createAccountButton.addTarget(self, action: #selector(showRegistrationScreen), for: .touchUpInside)
    }
    
    func endEditingFromClosures() {
        emailTextField.closure = { [weak self] in
            guard let self else { return }
            self.view.endEditing(true)
        }
        passwordTextField.closure = { [weak self] in
            guard let self else { return }
            self.view.endEditing(true)
        }
    }
    
    //  MARK: - objc method
    
    @objc func onSignInButtonTap() {
        if self.signInButton.backgroundColor == .blue {
            presenter.showMainScreen(email: emailTextField.text, password: passwordTextField.text)
        } else {
            showInvalidPasswordAlert()
        }
    }
    
    @objc func showRegistrationScreen() {
        presenter.showCreateAccountScreen()
    }
    
    @objc func keyboardWillShow(notification: NSNotification) {
        if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
            let buttonFrameInWindow = createAccountButton.convert(createAccountButton.bounds, to: nil)
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
}

//  MARK: - extension UITextFieldDelegate

extension SignInViewController: UITextFieldDelegate {
    func textFieldDidChangeSelection(_ textField: UITextField) {
        guard let passwordText = passwordTextField.text else { return }
        if passwordText.count >= 6 && emailTextField.text != "" {
            signInButton.backgroundColor = .blue
        } else {
            signInButton.backgroundColor = .gray
        }
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        passwordTextField.resignFirstResponder()
        emailTextField.resignFirstResponder()
         return true
     }
}

//  MARK: - extension SignUpDisplayLogic

extension SignInViewController: SignInDisplayLogic {
    func showNonExistentUserAlert() {
        let alertController = UIAlertController(title: "Non-existent user, check email and password", message: nil, preferredStyle: .alert)
        
        let actionTryAgain = UIAlertAction(title: "Try again", style: .destructive)
        alertController.addAction(actionTryAgain)
        
        present(alertController, animated: true)
    }
}
