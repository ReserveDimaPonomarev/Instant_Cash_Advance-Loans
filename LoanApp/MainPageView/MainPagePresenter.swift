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
    func showSignInScreen()
}

class MainPagePresenter: MainPagePresenterProtocol {
    
    //  MARK: - External properties
    
    weak var controller: MainPageDisplayLogic?
    
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
    
    func showWebViewOnMainPage() {
        let fromOpen = AppEvents.Name("AdsFormOpen")
        AppEvents.logEvent(fromOpen)
        coordinator.showWebView()
    }
    func showSignInScreen() {
        coordinator.showSignInScreen()
    }
    //  MARK: - Private Methods
    
}
