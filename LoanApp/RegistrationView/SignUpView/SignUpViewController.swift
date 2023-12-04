//
//  SignUpViewController.swift
//  LoanApp
//
//  Created by Дмитрий Пономарев on 30.11.2023.
//

import UIKit

protocol SignUpDisplayLogic: AnyObject {
    func sendTextField() -> String?
}

final class SignUpViewController: UIViewController {
    
    //  MARK: External dependencies
    
    var presenter: SignUpPresenterProtocol
    
    //  MARK: - UI properties
    
    private let backgroundImage = UIImageView()
    private let accountIcon = UIImageView()
    private let registrationLabel = CustomTitleLabel()
    private let userNameTextField = CusomTextFieldWithBorder()
    private let passwordTextField = CusomTextFieldWithBorder()
    private let saveButton = CustomButton()
    
    private let notification = NotificationCenter.default
    
    //  MARK: - init
    
    init(presenter: SignUpPresenterProtocol) {
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
 
private extension SignUpViewController {
    
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
        view.addSubview(saveButton)
    }
    
    func setupViews() {
        backgroundImage.image = UIImage(resource: .background)
        accountIcon.image = UIImage(resource: .accountPageIcon)
        registrationLabel.setupCustomTitleLabel(text: "Registration", textColor: .blue)
        userNameTextField.setupTextField(placeholder: "new username", backgroundColor: .white, borderColor: .blue, placehplderColor: .gray, textColor: .blue, borderWidth: 4)
        userNameTextField.closure = { [weak self] in
            self?.view.endEditing(true)
        }
        passwordTextField.setupTextField(placeholder: "new password", backgroundColor: .white, borderColor: .blue, placehplderColor: .gray, textColor: .blue, borderWidth: 4)
        passwordTextField.closure = { [weak self] in
            self?.view.endEditing(true)
        }
        saveButton.setupView(title: "Save", color: .blue, titleColor: .white)
        saveButton.addTarget(self, action: #selector(onSaveButtonTapped), for: .touchUpInside)
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
        
    func setupKeyboardNotifications() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    //  MARK: - objc method
    
    @objc func keyboardWillShow(notification: NSNotification) {
        if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
            let buttonFrameInWindow = saveButton.convert(saveButton.bounds, to: nil)
            let bottomOfButton = buttonFrameInWindow.maxY
            
            // Рассчитываем, насколько нужно поднять экран
            let offset = bottomOfButton + 50  - (self.view.frame.size.height - keyboardSize.height)
            if offset > 0 {
                self.view.frame.origin.y -= offset
            }
        }
    }
    
    @objc func keyboardWillHide(notification: NSNotification) {
        self.view.frame.origin.y = 0
    }
    
    @objc func onSaveButtonTapped() {
        presenter.showUserInfo()
    }
}

//  MARK: - extension SignUpDisplayLogic

extension SignUpViewController: SignUpDisplayLogic {
    func sendTextField() -> String? {
        return passwordTextField.text
    }
}