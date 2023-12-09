//
//  SignUpViewModel.swift
//  LoanApp
//
//  Created by Дмитрий Пономарев on 30.11.2023.
//


import Foundation

protocol RegistrationPresenterProtocol: AnyObject {
    func showUserInfo()
    var controller: RegistrationDisplayLogic? { get set }
    func sendingChanges(username: String, password: String) 
}

class RegistrationPresenter: RegistrationPresenterProtocol {
    
    //  MARK: - External properties
    
    weak var controller: RegistrationDisplayLogic?
    
    //  MARK: Data Variables
    
    
    // MARK: Private Variables
    
    private let coordinator: MainPageScreenOutput
    
    //  MARK: - Init
    
    init(coordinator: MainPageScreenOutput) {
        self.coordinator = coordinator
    }
//    
    deinit {
        print("SignUpPresenter deinited")
    }
    
    //  MARK: - Delegate methodes
    
    func showUserInfo() {
        coordinator.showUserInfoScreen()

//        TODO: - ниже указана валидация пароля
        
//        if checkIfPasswordContainsLettersAndDigits(userPassword: controller?.sendTextField()) {
//            coordinator.showUserInfoVC()
//        }
    }
    
    func sendingChanges(username: String, password: String) {
        if username.count & password.count < 6 {
            controller?.setButtonColorWhen(isAvailable: false)
        } else {
            controller?.setButtonColorWhen(isAvailable: true)
        }
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
}
