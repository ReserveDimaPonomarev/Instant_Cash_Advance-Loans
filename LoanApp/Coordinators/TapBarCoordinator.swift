//
//  TabBarCoordinator.swift
//  BettaBank
//
//  Created by Egor Kruglov on 08.11.2023.
//

import UIKit

final class TabBarCoordinator: BaseCoordinator {
    
    var onFinish: (() -> Void)?
    
    private lazy var tabBarViewController = getTabBarViewController()
    
    deinit {
        print(String(describing: Self.self) + " was deinited")
    }
    
    func start() {
        setTabBar()
        showMainScreen()
        showRegistrationScreen()
        howItWorksScreen()
        contactUsScreen()
    }
    
    func finish() {
        onFinish?()
    }
    
    private func setTabBar() {
        router.setViewControllers([tabBarViewController], isNavigationBarHidden: true)
    }
    
    private func showMainScreen() {
        let mainPageNavigationController = UINavigationController()
        let mainPageRouter = Router(navigationController: mainPageNavigationController)
        let mainPageCoordinator = MainPageCoordinator(router: mainPageRouter, parentCoordinator: self)
        mainPageCoordinator.start()
        
        addDependency(mainPageCoordinator)
        
        tabBarViewController.viewControllers = [mainPageNavigationController]
    }
    
    private func showRegistrationScreen() {
        let registerPageNavigationController = UINavigationController()
        let registerPageRouter = Router(navigationController: registerPageNavigationController)
        let registerPageCoordinator = RegisterPageCoordinator(router: registerPageRouter, parentCoordinator: self)
        registerPageCoordinator.start()
        
        addDependency(registerPageCoordinator)
        
        tabBarViewController.viewControllers?.append(registerPageNavigationController)
    }
    
    private func howItWorksScreen() {
        let howItWorksVC = HowItWorksViewController()
        howItWorksVC.tabBarItem = UITabBarItem().setupTabBarItem(image: .howItWorksPageIcon, text: "How It wotks")

        tabBarViewController.viewControllers?.append(howItWorksVC)
    }
    
    private func contactUsScreen() {
        let contactUsVC = ContactUsViewController()
        contactUsVC.tabBarItem = UITabBarItem().setupTabBarItem(image: .contactPageIcon, text: "Contact")

        tabBarViewController.viewControllers?.append(contactUsVC)
    }
}

private extension TabBarCoordinator {
    func getTabBarViewController() -> TabBarViewController {
        let tabBarViewController = TabBarViewController()
        
        return tabBarViewController
    }
}
