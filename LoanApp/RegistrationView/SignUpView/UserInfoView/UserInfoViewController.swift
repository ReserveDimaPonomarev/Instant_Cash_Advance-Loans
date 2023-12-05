//
//  UserInfoViewController.swift
//  LoanApp
//
//  Created by Дмитрий Пономарев on 01.12.2023.
//


import UIKit

protocol UserInfoDisplayLogic: AnyObject {
    
}

final class UserInfoViewController: UIViewController {
    
    //  MARK: External dependencies

    var presenter: UserInfoPresenterProtocol
    
    //  MARK: - UI properties
    
    private let scrollView = UIScrollView()
    private let contentView = UIView()
    private let backgroundImage = UIImageView()
    private let accountIcon = UIImageView()
    private let userInfoLabel = CustomTitleLabel()
    private let loginStackView = CustomStackView()
    private let changeButton = CustomButton()
    private let birthDayStackView = CustomStackView()
    private let nameStackView = CustomStackView()
    private let saveButton = CustomButton()
    private let logoutButton = CustomViewWithBorder()
    

    //  MARK: - init

    init(presenter: UserInfoPresenterProtocol) {
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
    }
    
    //  MARK: - setup UI
    
    private func setup() {
        addViews()
        setupViews()
        setupConstraints()
    }
        
    private func addViews() {
        view.backgroundColor = .white
        view.addSubview(backgroundImage)
        view.addSubview(scrollView)
        scrollView.addSubview(contentView)
        contentView.addSubview(backgroundImage)
        contentView.addSubview(accountIcon)
        contentView.addSubview(userInfoLabel)
        contentView.addSubview(loginStackView)
        contentView.addSubview(changeButton)
        contentView.addSubview(birthDayStackView)
        contentView.addSubview(nameStackView)
        contentView.addSubview(saveButton)
        contentView.addSubview(logoutButton)
    }
    
    private func setupViews() {
        backgroundImage.image = UIImage(resource: .background)
        accountIcon.image = UIImage(resource: .accountPageIcon)
        userInfoLabel.setupCustomTitleLabel(text: "User Info", textColor: .blue)
        loginStackView.setupSubViews(labelText: "login", textFieldPlaceholder: "email@mail.ru")
        changeButton.setupView(title: "Change", color: .blue, titleColor: .white)
        birthDayStackView.setupSubViews(labelText: "Birthday")
        nameStackView.setupSubViews(labelText: "Name")
        saveButton.setupView(title: "Save", color: .blue, titleColor: .white)
        birthDayStackView.inputtedTextField.createDatePicker()
        setupGestureOnLoginButton()
        endEditingFromClosures()
    }

    private func setupGestureOnLoginButton() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(onLogOutButtonTap))
        logoutButton.addGestureRecognizer(tapGesture)
    }
    
    private func setupConstraints() {
        scrollView.snp.makeConstraints { make in
            make.left.right.width.bottom.equalToSuperview()
            make.top.equalTo(view.safeAreaLayoutGuide)
            
        }
        contentView.snp.makeConstraints { make in
            make.top.leading.trailing.size.equalTo(scrollView)
            make.bottom.equalTo(scrollView)
        }
        backgroundImage.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        userInfoLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalToSuperview().offset(24)
        }
        accountIcon.snp.makeConstraints { make in
            make.bottom.equalTo(userInfoLabel).inset(8)
            make.trailing.equalTo(userInfoLabel.snp.leading).inset(-10)
            make.height.equalTo(userInfoLabel.intrinsicContentSize.height + 10)
            make.width.equalTo(accountIcon.snp.height)
        }
        loginStackView.snp.makeConstraints { make in
            make.top.equalTo(userInfoLabel.snp.bottom).offset(36)
            make.centerX.equalToSuperview()
            make.width.equalToSuperview().inset(50)
        }
        changeButton.snp.makeConstraints { make in
            make.top.equalTo(loginStackView.snp.bottom).offset(20)
            make.centerX.equalToSuperview()
            make.height.equalTo(60)
            make.width.equalTo(200)
        }
        birthDayStackView.snp.makeConstraints { make in
            make.top.equalTo(changeButton.snp.bottom).offset(18)
            make.centerX.equalToSuperview()
            make.width.equalToSuperview().inset(50)
        }
        nameStackView.snp.makeConstraints { make in
            make.top.equalTo(birthDayStackView.snp.bottom).offset(18)
            make.centerX.equalToSuperview()
            make.width.equalToSuperview().inset(50)
        }
        saveButton.snp.makeConstraints { make in
            make.top.equalTo(nameStackView.snp.bottom).offset(24)
            make.centerX.equalToSuperview()
            make.height.equalTo(60)
            make.width.equalTo(200)
        }
        logoutButton.snp.makeConstraints { make in
            make.top.equalTo(saveButton.snp.bottom).offset(36)
            make.centerX.equalToSuperview()
            make.height.equalTo(60)
            make.width.equalTo(250)
        }
    }
        
    //  MARK: - private methods
    
    private func findActiveField() -> UIView? {
        if loginStackView.inputtedTextField.isFirstResponder {
            return loginStackView.inputtedTextField
        } else if birthDayStackView.inputtedTextField.isFirstResponder {
            return birthDayStackView.inputtedTextField
        } else if nameStackView.inputtedTextField.isFirstResponder {
            return nameStackView.inputtedTextField
        }
        return nil
    }
    
    private func endEditingFromClosures() {
        birthDayStackView.inputtedTextField.closure = { [weak self] in
            guard let self else { return }
            self.view.endEditing(true)
        }
        nameStackView.inputtedTextField.closure = { [weak self] in
            guard let self else { return }
            self.view.endEditing(true)
        }
        loginStackView.inputtedTextField.closure = { [weak self] in
            guard let self else { return }
            self.view.endEditing(true)
        }
    }
    
    //  MARK: - addActions

    private func addActions() {
        changeButton.addTarget(self, action: #selector(onChangeButtonTap), for: .touchUpInside)
        saveButton.addTarget(self, action: #selector(onSaveButtonTap), for: .touchUpInside)

        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    //  MARK: - objc method
    
    // Метод показа клавиатуры и подъёма экрана наверх
    @objc func keyboardWillShow(notification: NSNotification) {
        if let activeField = findActiveField() {
            if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
                let buttonFrameInWindow = activeField.convert(activeField.bounds, to: nil)
                let bottomOfButton = buttonFrameInWindow.maxY
                
                // Рассчитываем, насколько нужно поднять экран
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
    
    @objc func onChangeButtonTap() {
        guard let text = loginStackView.inputtedTextField.text else { return }
        presenter.changeEmail(testEmail: text)
        
    }
    
    @objc func onSaveButtonTap() {
        presenter.saveUsersDataInProfile()
    }
    
    @objc func onLogOutButtonTap() {
        presenter.logoutCurrentUser()
    }
}

//  MARK: - extension UserInfoDisplayLogic

extension UserInfoViewController: UserInfoDisplayLogic {

}
