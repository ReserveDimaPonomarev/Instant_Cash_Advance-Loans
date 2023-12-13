//
//  FactoryLoading.swift
//  LoanApp
//
//  Created by Дмитрий Пономарев on 09.12.2023.
//

import Foundation
import UIKit

protocol LoadingFactoryProtocol {
    func createLoadingScreen(coordinator: LoginOutput) -> LoadingPageViewController
    func createFirstScreen(coordinator: LoginOutput) -> FirstViewController
    func createSecondScreen(coordinator: LoginOutput) -> SecondViewController
    func createThirdScreen(coordinator: LoginOutput) -> ThirdViewController 
}

protocol MainPageFactoryProtocol {
    func showSignInScreen(coordinator: MainPageScreenOutput, userData: UserData?) -> SignInViewController
    func showRegistrationScreen(coordinator: MainPageScreenOutput) -> RegistrationViewController
    func showUserInfoScreen(coordinator: MainPageScreenOutput, _ userData: UserData) -> UserInfoViewController
    func getMainPageViewController(coordinator: MainPageScreenOutput, userData: UserData?) -> MainPageViewController
    func showMainScreen(_ userData: UserData) -> UIViewController
}

class ScreenFactory {
    
    private var rootViewControll: UIViewController?
    
}

//  MARK: - extension FactoryLoadingProtocol

extension ScreenFactory: LoadingFactoryProtocol {
    
    func createLoadingScreen(coordinator: LoginOutput) -> LoadingPageViewController {
        let loadingPresenter = LoadingPagePresenter(coordinator: coordinator)
        let loadingVC = LoadingPageViewController(presenter: loadingPresenter)
        loadingPresenter.controller = loadingVC
        
        return loadingVC
    }
    
    func createFirstScreen(coordinator: LoginOutput) -> FirstViewController{
        let firstVC = FirstViewController()
        firstVC.loginOutput = coordinator
        
        return firstVC
    }
    
    func createSecondScreen(coordinator: LoginOutput) -> SecondViewController {
        let secondVC = SecondViewController()
        secondVC.loginOutput = coordinator
        
        return secondVC
    }
    
    func createThirdScreen(coordinator: LoginOutput) -> ThirdViewController {
        let thirdVC = ThirdViewController()
        thirdVC.loginOutput = coordinator
        
        return thirdVC
    }
}

//  MARK: - extension MainPageFactoryProtocol

extension ScreenFactory: MainPageFactoryProtocol {
    
    func showSignInScreen(coordinator: MainPageScreenOutput, userData: UserData?) -> SignInViewController {
        let signInPresenter = SignInPresenter(coordinator: coordinator, userData: userData)
        let signInViewController = SignInViewController(presenter: signInPresenter)
        signInPresenter.controller = signInViewController
        
        return signInViewController
    }
    
    func showRegistrationScreen(coordinator: MainPageScreenOutput) -> RegistrationViewController  {
        let registrationPresenter = RegistrationPresenter(coordinator: coordinator)
        let registrationViewController = RegistrationViewController(presenter: registrationPresenter)
        registrationPresenter.controller = registrationViewController

        return registrationViewController
    }
    
    func showUserInfoScreen(coordinator: MainPageScreenOutput, _ userData: UserData) -> UserInfoViewController {
        let userInfoPresenter = UserInfoPresenter(userData: userData, coordinator: coordinator)
        let userInfoViewController = UserInfoViewController(presenter: userInfoPresenter)
        userInfoPresenter.controller = userInfoViewController
        return userInfoViewController
    }
    
    func getMainPageViewController(coordinator: MainPageScreenOutput, userData: UserData?) -> MainPageViewController {
        let mainPagePresenter = MainPagePresenter(coordinator: coordinator, userData: userData)
        let mainPageViewController = MainPageViewController(presenter: mainPagePresenter)
        rootViewControll = mainPageViewController
        mainPageViewController.tabBarItem = UITabBarItem().setupTabBarItem(image: .mainPageIcon, text: "Main")

        return mainPageViewController
    }
    
    func showMainScreen(_ userData: UserData) -> UIViewController {
        guard let vc = rootViewControll as? MainPageViewController else { return UIViewController()}
        let presenter = vc.presenter
        presenter.userData = userData
        return vc
    }
    
}
