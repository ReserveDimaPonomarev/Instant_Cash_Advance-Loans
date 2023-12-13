//
//  MainPageCoordinator.swift
//  BettaBank
//
//  Created by Margarita Slesareva on 13.11.2023.
//

import UIKit

protocol MainPageScreenOutput: AnyObject {
    func showWebView()
    func showSignInScreen()
    func showRegistrationScreen()
    func showMainScreen(_ userData: UserData)
    func showUserInfoScreen(_ userData: UserData)
}

final class MainPageCoordinator: BaseCoordinator {
    
    let parentCoordinator: TabBarCoordinator
    private let userData: UserData?
    private var rootViewControll: UIViewController?
    private let mainPageFactory: MainPageFactoryProtocol
    
    init(router: Router, parentCoordinator: TabBarCoordinator, userData: UserData?, mainPageFactory: MainPageFactoryProtocol) {
        self.parentCoordinator = parentCoordinator
        self.userData = userData
        self.mainPageFactory = mainPageFactory
        super.init(router: router)
    }
    
    func start() {
        showMainPageScreen()
    }
    
    func finish() {
        parentCoordinator.finish()
    }
    
    private func showMainPageScreen() {
        let mainPageViewController = mainPageFactory.getMainPageViewController(coordinator: self, userData: self.userData)
        router.setViewControllers([mainPageViewController])
    }
}

extension MainPageCoordinator: MainPageScreenOutput {
    
    func showWebView() {
        let webViewController = WebViewViewController()
        router.push(webViewController)
    }
    
    func showSignInScreen() {
        let signInViewController = mainPageFactory.showSignInScreen(coordinator: self, userData: userData)
        router.push(signInViewController)
    }
    
    func showRegistrationScreen() {
        let registrationVC = mainPageFactory.showRegistrationScreen(coordinator: self)
        router.push(registrationVC)
    }
    
    func showUserInfoScreen(_ userData: UserData) {
        let userInfoVC = mainPageFactory.showUserInfoScreen(coordinator: self, userData)
        router.push(userInfoVC)
    }
    
    func showMainScreen(_ userData: UserData) {
        let mainPage = mainPageFactory.showMainScreen(userData)
        router.pop(mainPage, animated: true)
    }
}
