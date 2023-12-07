//
//  MainPageCoordinator.swift
//  BettaBank
//
//  Created by Margarita Slesareva on 13.11.2023.
//

import UIKit

protocol MainPageScreenOutput: AnyObject {
    func showWebView()
}

final class MainPageCoordinator: BaseCoordinator {
    
    let parentCoordinator: TabBarCoordinator
    
    init(router: Router, parentCoordinator: TabBarCoordinator) {
        self.parentCoordinator = parentCoordinator
        super.init(router: router)
    }
    
    func start() {
        showMainPageScreen()
    }
    
    func finish() {
        parentCoordinator.finish()
    }
    
    private func showMainPageScreen() {
        let mainPageViewController = getMainPageViewController()
        mainPageViewController.tabBarItem = UITabBarItem().setupTabBarItem(image: .mainPageIcon, text: "Main")
        router.setViewControllers([mainPageViewController])
    }
    
    private func getMainPageViewController() -> UIViewController {
        let mainPagePresenter = MainPagePresenter(coordinator: self)
        let mainPageViewController = MainPageViewController(presenter: mainPagePresenter)
        return mainPageViewController
    }
}

extension MainPageCoordinator: MainPageScreenOutput {
    
    func showWebView() {
        let webViewController = WebViewViewController()
        router.push(webViewController)
    }
}
