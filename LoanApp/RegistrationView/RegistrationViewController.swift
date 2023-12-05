//
//  RegistrationViewController.swift
//  LoanApp
//
//  Created by Дмитрий Пономарев on 30.11.2023.
//


import UIKit

protocol RegistrationDisplayLogic: AnyObject {
    
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
    private let signUpButton = CustomButton()
    private let signInButton = CustomButton()
    
    //  MARK: - init
    
    init(presenter: RegistrationPresenterProtocol) {
        self.presenter = presenter
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    deinit {
        print("deinited")
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
    }
        
    func addViews() {
        view.addSubview(backgroundImage)
        view.addSubview(accountIcon)
        view.addSubview(registrationLabel)
        view.addSubview(userNameTextField)
        view.addSubview(passwordTextField)
        view.addSubview(signUpButton)
        view.addSubview(signInButton)
    }
    
    func setupViews() {
        backgroundImage.image = UIImage(resource: .background)
        accountIcon.image = UIImage(resource: .accountPageIcon)
        registrationLabel.setupCustomTitleLabel(text: "Registration", textColor: .blue)
        userNameTextField.setupTextField(placeholder: "username", backgroundColor: .white, borderColor: .blue, placehplderColor: .gray, textColor: .blue, borderWidth: 4)

        passwordTextField.setupTextField(placeholder: "password", backgroundColor: .white, borderColor: .blue, placehplderColor: .gray, textColor: .blue, borderWidth: 4)

        signInButton.setupView(title: "Sign In", color: .blue, titleColor: .white)
        signUpButton.setupView(title: "Sign Up", color: .blue, titleColor: .white)
        signUpButton.addTarget(self, action: #selector(showRegistrationScreen), for: .touchUpInside)
        endEditingFromClosures()
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
        signUpButton.snp.makeConstraints { make in
            make.top.equalTo(passwordTextField.snp.bottom).offset(20)
            make.centerX.equalToSuperview()
            make.height.equalTo(60)
            make.width.equalTo(200)
        }
        signInButton.snp.makeConstraints { make in
            make.top.equalTo(signUpButton.snp.bottom).offset(20)
            make.centerX.equalToSuperview()
            make.height.equalTo(60)
            make.width.equalTo(200)
        }
    }
    
    //  MARK: - addActions

    func addActions() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
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
    
    @objc func showRegistrationScreen() {
        presenter.showSignUpScreen()
    }
    
    @objc func keyboardWillShow(notification: NSNotification) {
        if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
            let buttonFrameInWindow = signUpButton.convert(signUpButton.bounds, to: nil)
            let bottomOfButton = buttonFrameInWindow.maxY
            let offset = bottomOfButton + 50  - (self.view.frame.size.height - keyboardSize.height)
            if offset > 0 {
                self.view.frame.origin.y -= offset
            }
        }
    }
    
    @objc func keyboardWillHide(notification: NSNotification) {
        self.view.frame.origin.y = 0
    }
}

//  MARK: - extension SignUpDisplayLogic

extension RegistrationViewController: RegistrationDisplayLogic {

}
