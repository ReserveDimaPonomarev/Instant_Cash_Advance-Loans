//
//  SignUpViewModel.swift
//  LoanApp
//
//  Created by Дмитрий Пономарев on 30.11.2023.
//


import Foundation

protocol RegistrationPresenterProtocol: AnyObject {
    func makeErrorDescriptionIfIsInvalid(_ userEmail: String, _ userPassword: String)
    var controller: RegistrationDisplayLogic? { get set }
    func checkPaswordAndEmailOnValidation(userEmail: String, userPassword: String)
}


class RegistrationPresenter {
    
    //  MARK: - External properties
    
    weak var controller: RegistrationDisplayLogic?
    
    //  MARK: Data Variables
    
    
    // MARK: Private Variables
    
    private let coordinator: MainPageScreenOutput
    
    //  MARK: - Init
    
    init(coordinator: MainPageScreenOutput) {
        self.coordinator = coordinator
    }
}

//  MARK: - Private methods

private extension RegistrationPresenter {
    
    private func validateEmail(_ userEmail: String?) -> String? {
        let emailRegEx = #"^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$"#
        let emailPredicate = NSPredicate(format: "SELF MATCHES %@", emailRegEx)
        
        if emailPredicate.evaluate(with: userEmail) {
            return nil
        } else {
            return "Incorrect email"
        }
    }
    
    private func validatePassword(_ userPassword: String) -> String? {
        let hasLetters = containsLetters(password: userPassword)
        let hasDigits = containsDigits(password: userPassword)
        let hasSixSymbols = userPassword.count >= 6
        
        if hasLetters && hasDigits && hasSixSymbols {
            return nil
        } else if !hasLetters {
            return "The password must contain at least one Latin letter"
        } else if !hasDigits {
            return "The password must contain at least one digit"
        } else if !hasSixSymbols {
            return "The password must be at least 6 characters long"
        }
        return "Enter login and password"
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

//  MARK: - extension RegistrationPresenterProtocol

extension RegistrationPresenter: RegistrationPresenterProtocol {
    
    func makeErrorDescriptionIfIsInvalid(_ userEmail: String, _ userPassword: String) {
        let emailValidationResult = validateEmail(userEmail)
        let passwordValidationResult = validatePassword(userPassword)
        
        switch (emailValidationResult, passwordValidationResult) {
        case (let email?, let password?):
            controller?.showRegistrationErrorWith("\(email)\n\(password)")
        case (let email?, _):
            controller?.showRegistrationErrorWith(email)
        case (_, let password?):
            controller?.showRegistrationErrorWith(password)
        case (nil, nil):
            let userData = UserData(email: userEmail, password: userPassword)
            coordinator.showUserInfoScreen(userData)
        }
    }
    
    func checkPaswordAndEmailOnValidation(userEmail: String, userPassword: String) {
        if validatePassword(userPassword) == nil && validateEmail(userEmail) == nil {
            controller?.setButtonColorWhen(isEnabled: true)
        } else {
            controller?.setButtonColorWhen(isEnabled: false)
        }
    }
}
