//
//  Router.swift
//  LoanApp
//
//  Created by Дмитрий Пономарев on 30.11.2023.
//

import UIKit

final class Router {
    private let navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func popToRootViewController() {
        let rootViewController = self.navigationController.viewControllers[0]
        self.navigationController.popToViewController(rootViewController, animated: true)
    }
    
    func setTabBarItem(_ tabBarItem: UITabBarItem) {
        navigationController.tabBarItem = tabBarItem
    }
    
    func push(_ viewController: UIViewController, animated: Bool = true) {
        navigationController.pushViewController(viewController, animated: animated)
    }
    
    func pop(_ viewController: UIViewController, animated: Bool = true) {
        navigationController.popToViewController(viewController, animated: animated)
    }
    
    func present(
        _ viewController: UIViewController,
        animated: Bool = true,
        presentationStyle: UIModalPresentationStyle = .automatic
    ) {
        viewController.modalPresentationStyle = presentationStyle
        navigationController.present(viewController, animated: animated)
    }
    
    func dismiss(_ viewController: UIViewController, animated: Bool = true) {
        viewController.dismiss(animated: animated)
    }
    
    func setViewControllers(_ viewControllers: [UIViewController], isNavigationBarHidden: Bool = false) {
        navigationController.setViewControllers(viewControllers, animated: false)
        navigationController.setNavigationBarHidden(isNavigationBarHidden, animated: false)
    }
}
