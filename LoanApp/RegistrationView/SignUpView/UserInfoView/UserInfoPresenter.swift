//
//  SignUpViewModel.swift
//  LoanApp
//
//  Created by Дмитрий Пономарев on 30.11.2023.
//


import Foundation

protocol UserInfoPresenterProtocol: AnyObject {
    var controller: UserInfoDisplayLogic? { get set }
}

class UserInfoPresenter: UserInfoPresenterProtocol {
    
    //  MARK: - External properties
    
    private let coordinator: RegisterPageScreenOutput
    weak var controller: UserInfoDisplayLogic?
    
    //  MARK: Data Variables
    
    
    // MARK: Private Variables
    
    
    //  MARK: - Init
    
    init(coordinator: RegisterPageScreenOutput) {
        self.coordinator = coordinator
    }
    
    deinit {
        print("deinited")
    }
    
    //  MARK: - Delegate methodes
    
    func showUserInfo() {
        coordinator.showUserInfoVC()

//        TODO: - ниже указана валидация пароля
//        if checkIfPasswordContainsLettersAndDigits(userPassword: controller?.sendTextField()) {
//            coordinator.showUserInfoVC()
//        }
    }
    
    //  MARK: - Private Methods
    
    private func checkIfPasswordContainsLettersAndDigits(userPassword: String?) -> Bool {
        guard let userEmail = userPassword else { return false }
        let hasLetters = containsLetters(password: userEmail)
        let hasDigits = containsDigits(password: userEmail)
        let passwordLength = userEmail.count >= 6
        switch (hasLetters, hasDigits, passwordLength) {
        case (true, true, true):
            print("Пароль содержит буквы и цифры, и подходит под валидацию")
            return true
        case (true, false, true):
            print("Пароль должен содержать как минимум одну цифру")
            return false
        case (false, true, true):
            print("Пароль должен содержать как минимум одну латинскую букву")
            return false
        case (true, true, false):
            print("Пароль должен быть как минимум 6 символов")
            return false
        default: return false
        }
    }
    
    private func containsLetters(password: String) -> Bool {
        let letterRegex = ".*[a-zA-Z]+.*"
        return NSPredicate(format: "SELF MATCHES %@", letterRegex).evaluate(with: password)
    }
    
    private func containsDigits(password: String) -> Bool {
        let digitRegex = ".*[0-9]+.*"
        return NSPredicate(format: "SELF MATCHES %@", digitRegex).evaluate(with: password)
    }
    
    private func isValidEmail(_ email: String) -> Bool {
        let emailRegex = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"
        let emailPredicate = NSPredicate(format: "SELF MATCHES %@", emailRegex)
        return emailPredicate.evaluate(with: email)
    }
}

