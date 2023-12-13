//
//  MainPageViewModel.swift
//  LoanApp
//
//  Created by Дмитрий Пономарев on 30.11.2023.
//


import Foundation
import FBSDKCoreKit

protocol MainPagePresenterProtocol: AnyObject {
    var controller: MainPageDisplayLogic? { get set }
    func showWebViewOnMainPage()
    func isUserAuthorized() -> Bool 
    func userSignOut() 
    func userSignedIn()
    var userData: UserData? { get set }
}

class MainPagePresenter {
    
    //  MARK: - External properties
    
    weak var controller: MainPageDisplayLogic?
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

//  MARK: - extension MainPagePresenterProtocol

extension MainPagePresenter: MainPagePresenterProtocol {
    
    func showWebViewOnMainPage() {
        coordinator.showWebView()
    }
    
    func isUserAuthorized() -> Bool {
        if userData != nil {
            return true
        } else {
            return false
        }
    }
    
    func userSignOut() {
        userData = nil
    }
    
    func userSignedIn() {
        coordinator.showSignInScreen()
//        userData = UserData(email: "koko")
    }
}
