//
//  SignUpViewModel.swift
//  LoanApp
//
//  Created by Дмитрий Пономарев on 30.11.2023.
//


import Foundation

protocol SignUpViewModelProtocol: AnyObject {
    func showUserInfo()
    var controller: SomeProtocol? { get set }
}

class SignUpViewModel: SignUpViewModelProtocol {
    
    //  MARK: - External properties
    
    private let coordinator: RegisterPageScreenOutput
    weak var controller: SomeProtocol?

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
        guard let userEmail = controller?.sendTextField() else { return }
        if isValidEmail(userEmail) {
            coordinator.showUserInfoVC()
        } else {
            print("Email недействителен.")
        }
    }
    
    //  MARK: - Private Methods
    
    private func isValidEmail(_ email: String) -> Bool {
        let emailRegex = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"
        let emailPredicate = NSPredicate(format: "SELF MATCHES %@", emailRegex)
        return emailPredicate.evaluate(with: email)
    }
}

