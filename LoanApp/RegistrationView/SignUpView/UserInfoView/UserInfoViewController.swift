//
//  UserInfoViewController.swift
//  LoanApp
//
//  Created by Дмитрий Пономарев on 01.12.2023.
//


import UIKit

protocol UserInfoDisplayLogic: AnyObject {
    func setButtonColorWhen(isEnabled: Bool)
}

final class UserInfoViewController: UIViewController {
    
    //  MARK: External dependencies

    var presenter: UserInfoPresenterProtocol
    
    //  MARK: - UI properties
    
    // TODO: - если необходимо реализовать функционал сменить пароль, то раскоммитить все, связанное с changeButton

    private let scrollView = UIScrollView()
    private let contentView = UIView()
    private let backgroundImage = UIImageView()
    private let accountIcon = UIImageView()
    private let userInfoLabel = CustomTitleLabel()
    private let emailStackView = CustomStackView()
    private let birthDayStackView = CustomStackView()
    private let nameStackView = CustomStackView()
    private let saveButton = CustomButton()
    

    //  MARK: - init

    init(presenter: UserInfoPresenterProtocol) {
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
    }
}

//  MARK: - private methods

private extension UserInfoViewController {
    
    //  MARK: - setup UI
    
    private func setup() {
        addViews()
        setupViews()
        endEditingFromClosures()
        setupConstraints()
        addActions()
    }
        
    private func addViews() {
        view.backgroundColor = .white
        view.addSubview(backgroundImage)
        view.addSubview(scrollView)
        scrollView.addSubview(contentView)
        contentView.addSubview(backgroundImage)
        contentView.addSubview(accountIcon)
        contentView.addSubview(userInfoLabel)
        contentView.addSubview(emailStackView)
        contentView.addSubview(birthDayStackView)
        contentView.addSubview(nameStackView)
        contentView.addSubview(saveButton)
    }
    
    private func setupViews() {
        backgroundImage.image = UIImage(resource: .background)
        accountIcon.image = UIImage(resource: .accountPageIcon)
        userInfoLabel.setupCustomTitleLabel(text: "User Info", textColor: .blue)
        emailStackView.setupSubViews(labelText: "Email", textFieldPlaceholder: presenter.showUserEmail())
        emailStackView.inputtedTextField.isEnabled = false
        
        birthDayStackView.setupSubViews(labelText: "Birthday")
        birthDayStackView.inputtedTextField.delegate = self
        
        nameStackView.setupSubViews(labelText: "Name")
        nameStackView.inputtedTextField.delegate = self
        
        saveButton.setupView(title: "Save", color: .gray, titleColor: .white)

        birthDayStackView.inputtedTextField.createDatePicker()
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(keyboardWillHide))
        view.addGestureRecognizer(tapGesture)
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
        emailStackView.snp.makeConstraints { make in
            make.top.equalTo(userInfoLabel.snp.bottom).offset(36)
            make.centerX.equalToSuperview()
            make.width.equalToSuperview().inset(50)
        }
        birthDayStackView.snp.makeConstraints { make in
            make.top.equalTo(emailStackView.snp.bottom).offset(18)
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
    }
        
    //  MARK: - private methods
    
    private func findActiveField() -> UIView? {
        if emailStackView.inputtedTextField.isFirstResponder {
            return emailStackView.inputtedTextField
        } else if birthDayStackView.inputtedTextField.isFirstResponder {
            return birthDayStackView.inputtedTextField
        } else if nameStackView.inputtedTextField.isFirstResponder {
            return nameStackView.inputtedTextField
        }
        return nil
    }
    
    //  MARK: - addActions

    private func addActions() {
        saveButton.addTarget(self, action: #selector(onSaveButtonTap), for: .touchUpInside)

        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
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
        emailStackView.inputtedTextField.closure = { [weak self] in
            guard let self else { return }
            self.view.endEditing(true)
        }
    }
    
    //  MARK: - objc method
    
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
    
    @objc func keyboardWillHide() {
        self.view.endEditing(true)
    }
    
    @objc func onSaveButtonTap() {
        guard let birthday = birthDayStackView.inputtedTextField.text,
              let name = nameStackView.inputtedTextField.text else { return }
        presenter.saveUsersDataInProfile(birhday: birthday, name: name)
    }
}

extension UserInfoViewController: UITextFieldDelegate {
    func textFieldDidChangeSelection(_ textField: UITextField) {
        guard let nameText = nameStackView.inputtedTextField.text,
              let birthdayText = birthDayStackView.inputtedTextField.text else { return }
        
        presenter.sendingChanges(birthdayText, nameText)
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        nameStackView.inputtedTextField.resignFirstResponder()
        birthDayStackView.inputtedTextField.resignFirstResponder()
        return true
     }
}

//  MARK: - extension UserInfoDisplayLogic

extension UserInfoViewController: UserInfoDisplayLogic {
    func setButtonColorWhen(isEnabled: Bool) {
        saveButton.backgroundColor = isEnabled ? .blue : .gray
    }
}
