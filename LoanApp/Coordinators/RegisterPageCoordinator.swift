//
//  RegisterPageCoordinator.swift
//  LoanApp
//
//  Created by Дмитрий Пономарев on 30.11.2023.
//

import Foundation

//
//  MainPageCoordinator.swift
//  BettaBank
//
//  Created by Margarita Slesareva on 13.11.2023.
//

import UIKit

protocol RegisterPageScreenOutput: AnyObject {
    func showSignUpScreen()
    func showUserInfoVC()
    func showMainScreen()
}

final class RegisterPageCoordinator: BaseCoordinator {
    
    let parentCoordinator: TabBarCoordinator
    
    init(router: Router, parentCoordinator: TabBarCoordinator) {
        self.parentCoordinator = parentCoordinator
        super.init(router: router)
    }
    
    func start() {
        showRegisterPageScreen()
    }
    
    func finish() {
        parentCoordinator.finish()
    }
    
    private func showRegisterPageScreen() {
        let registerPageViewController = getRegisterPageViewController()
        registerPageViewController.tabBarItem = UITabBarItem().setupTabBarItem(image: .accountPageIcon, text: "Registration")

        router.setViewControllers([registerPageViewController])
    }
    
    private func getRegisterPageViewController() -> UIViewController {
        let registerPageViewController = RegistrationViewController(output: self)
        return registerPageViewController
    }
}

extension RegisterPageCoordinator: RegisterPageScreenOutput {
    
    func showSignUpScreen() {
        let signUpPresenter = SignUpPresenter(coordinator: self)
        let signUpVC = SignUpViewController(presenter: signUpPresenter)
        signUpPresenter.controller = signUpVC
        
        router.push(signUpVC)
    }
    
    func showUserInfoVC() {
        let userInfoPresenter = UserInfoPresenter(coordinator: self)
        let userInfoVC = UserInfoViewController(presenter: userInfoPresenter)
        userInfoPresenter.controller = userInfoVC
        
        router.push(userInfoVC)
    }
    
    func showMainScreen() {
        
        parentCoordinator.showMainPageAfterRegistrationScreen()
        
    }

}
