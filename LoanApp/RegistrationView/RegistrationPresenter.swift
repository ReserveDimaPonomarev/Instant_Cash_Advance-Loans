//
//  UserInfoPresenter.swift
//  LoanApp
//
//  Created by Дмитрий Пономарев on 30.11.2023.
//


import Foundation

protocol RegistrationPresenterProtocol: AnyObject {
    var controller: RegistrationDisplayLogic? { get set }
    func showSignUpScreen()
}

class RegistrationPresenter: RegistrationPresenterProtocol {
    
    //  MARK: - External properties
    
    weak var controller: RegistrationDisplayLogic?
    
    //  MARK: Data Variables
    
    
    // MARK: Private Variables
    
    private let coordinator: RegistrationPageScreenOutput
    
    //  MARK: - Init
    
    init(coordinator: RegistrationPageScreenOutput) {
        self.coordinator = coordinator
    }
    
    deinit {
        print("deinited")
    }
    
    //  MARK: - Delegate methodes
    
    
    
    //  MARK: - Private Methods
    
    
}

extension RegistrationPresenter {
    
    func showSignUpScreen() {
        coordinator.showSignUpScreen()
    }
}
