//
//  UserInfoPresenter.swift
//  LoanApp
//
//  Created by Дмитрий Пономарев on 30.11.2023.
//


import Foundation

protocol UserInfoPresenterProtocol: AnyObject {
    var controller: UserInfoDisplayLogic? { get set }
    func changeEmail(testEmail: String)
    func saveUsersDataInProfile()
    func logoutCurrentUser()
}

class UserInfoPresenter {
    
    //  MARK: - External properties
    
    private let coordinator: RegistrationPageScreenOutput
    weak var controller: UserInfoDisplayLogic?
    
    //  MARK: Data Variables
    
    
    // MARK: Private Variables
    
    
    //  MARK: - Init
    
    init(coordinator: RegistrationPageScreenOutput) {
        self.coordinator = coordinator
    }
    
    deinit {
        print("UserInfoPresenter deinited")
    }
    
    //  MARK: - Delegate methodes
    
    
}

//  MARK: - Private Methods

private func isValidEmail(_ email: String) -> Bool {
    let emailRegex = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"
    let emailPredicate = NSPredicate(format: "SELF MATCHES %@", emailRegex)
    return emailPredicate.evaluate(with: email)
}


extension UserInfoPresenter: UserInfoPresenterProtocol {
    
    func changeEmail(testEmail: String) {
        if isValidEmail(testEmail) {
            print("\(testEmail) - корректный адрес электронной почты")
        } else {
            print("\(testEmail) - некорректный адрес электронной почты")
        }
    }
    
    func saveUsersDataInProfile() {
        coordinator.showMainScreen()
    }
    
    func logoutCurrentUser() {
        coordinator.showMainScreen()
    }
}
