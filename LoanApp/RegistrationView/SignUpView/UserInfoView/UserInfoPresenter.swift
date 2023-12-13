//
//  UserInfoPresenter.swift
//  LoanApp
//
//  Created by Дмитрий Пономарев on 30.11.2023.
//


import Foundation

protocol UserInfoPresenterProtocol: AnyObject {
    var controller: UserInfoDisplayLogic? { get set }
    func saveUsersDataInProfile(birhday: String, name: String)
    func sendingChanges(_ nameText: String, _ birthdayText: String)
    func showUserEmail() -> String
}

class UserInfoPresenter {
    
    //  MARK: - External properties
    
    var userData: UserData
    private let coordinator: MainPageScreenOutput
    weak var controller: UserInfoDisplayLogic?
    
    //  MARK: Data Variables
    
    
    // MARK: Private Variables
    
    
    //  MARK: - Init
    
    init(userData: UserData, coordinator: MainPageScreenOutput) {
        self.userData = userData
        self.coordinator = coordinator
    }
    
    //  MARK: - Private methods
    
}

//  MARK: - extension UserInfoPresenterProtocol

extension UserInfoPresenter: UserInfoPresenterProtocol {
    
    func showUserEmail() -> String {
        guard let password = userData.email else { return ""}
        return password
    }
    
    func saveUsersDataInProfile(birhday: String, name: String) {
        self.userData.birthday = birhday
        self.userData.name = name
        coordinator.showMainScreen(userData)
    }
    
    func sendingChanges(_ nameText: String, _ birthdayText: String) {
        if nameText != "", birthdayText != "" {
            controller?.setButtonColorWhen(isEnabled: true)
        } else {
            controller?.setButtonColorWhen(isEnabled: false)
        }
    }
}
