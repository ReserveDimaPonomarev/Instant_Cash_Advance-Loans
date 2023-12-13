//
//  TabBarCoordinator.swift
//  BettaBank
//
//  Created by Egor Kruglov on 08.11.2023.
//

import UIKit

protocol TabBarInputProtocol {
    
}

final class TabBarCoordinator: BaseCoordinator {
    
    var onFinish: (() -> Void)?
    var userData: UserData?
    private lazy var tabBarViewController = getTabBarViewController()
    
    func start() {
        
        setTabBar()
        howItWorksScreen()
        showMainScreen()
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
        let factory = ScreenFactory()
        let mainPageCoordinator = MainPageCoordinator(router: mainPageRouter, parentCoordinator: self, userData: userData, mainPageFactory: factory)
        mainPageCoordinator.start()
        addDependency(mainPageCoordinator)
        
        tabBarViewController.viewControllers?.append(mainPageNavigationController)
    }
    
    private func howItWorksScreen() {
        let howItWorksVC = HowItWorksViewController()
        howItWorksVC.tabBarItem = UITabBarItem().setupTabBarItem(image: .howItWorksPageIcon, text: "How It works")
        
        tabBarViewController.viewControllers = [howItWorksVC]
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

extension TabBarCoordinator: TabBarInputProtocol {
    
}
