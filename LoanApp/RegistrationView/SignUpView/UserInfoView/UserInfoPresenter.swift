//
//  UserInfoPresenter.swift
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
    
    func showUserInfo(testEmail: String) {
        if isValidEmail(testEmail) {
            print("\(testEmail) - корректный адрес электронной почты")
        } else {
            print("\(testEmail) - некорректный адрес электронной почты")
        }
    }
    
    //  MARK: - Private Methods
    
    private func isValidEmail(_ email: String) -> Bool {
        let emailRegex = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"
        let emailPredicate = NSPredicate(format: "SELF MATCHES %@", emailRegex)
        return emailPredicate.evaluate(with: email)
    }
}
