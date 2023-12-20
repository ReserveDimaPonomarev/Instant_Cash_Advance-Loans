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
    func showMainScreen(email: String?, password: String?)
}
class SignInPresenter {
    
    //  MARK: - External properties
    
    weak var controller: SignInDisplayLogic?
    var userData: UserData?
    //  MARK: Data Variables
    
    
    // MARK: Private Variables
    
    private let coordinator: MainPageScreenOutput
    
    //  MARK: - Init
    
    init(coordinator: MainPageScreenOutput, userData: UserData?) {
        self.coordinator = coordinator
        self.userData = userData
    }
    
    //  MARK: - Private Methods

}

//  MARK: - extension SignInPresenterProtocol
    
extension SignInPresenter: SignInPresenterProtocol {
    
    func showMainScreen(email: String?, password: String?) {
        userData = UserData(email: "testuser@mail.com", password: "testPasswd1")
        if email?.lowercased() == userData?.email?.lowercased() && password == userData?.password {
            let userData = UserData(email: email?.lowercased(), password: password)
            coordinator.showMainScreen(userData)
        } else {
            controller?.showNonExistentUserAlert()
        }
    }
    
    func showCreateAccountScreen() {
        coordinator.showRegistrationScreen()
    }
}
