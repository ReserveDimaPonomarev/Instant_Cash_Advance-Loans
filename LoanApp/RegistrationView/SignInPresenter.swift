//
//  UserInfoPresenter.swift
//  LoanApp
//
//  Created by Дмитрий Пономарев on 30.11.2023.
//


import Foundation

protocol SignInPresenterProtocol: AnyObject {
    var controller: SignInDisplayLogic? { get set }
    func showCreateAccountScreen()
    func showMainScreen()
    func sendingChanges(username: String, password: String)
}

class SignInPresenter: SignInPresenterProtocol {
    
    //  MARK: - External properties
    
    weak var controller: SignInDisplayLogic?
    
    //  MARK: Data Variables
    
    
    // MARK: Private Variables
    
    private let coordinator: MainPageScreenOutput
    
    //  MARK: - Init
    
    init(coordinator: MainPageScreenOutput) {
        self.coordinator = coordinator
    }
    
    deinit {
        print("RegistrationPresenter deinited")
    }
    
    //  MARK: - Delegate methodes
    
    func sendingChanges(username: String, password: String) {
        if username.count & password.count < 6 {
            controller?.setButtonColorWhen(isAvailable: false)
        } else {
            controller?.setButtonColorWhen(isAvailable: true)
        }
    }
    
    func showMainScreen() {
        coordinator.showMainScreen()
    }
    
    func showCreateAccountScreen() {
        coordinator.showRegistrationScreen()
    }



    
    //  MARK: - Private Methods
    
    
}

extension SignInPresenter {
    

}
