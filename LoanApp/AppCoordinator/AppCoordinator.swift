//
//  AppCoordinator.swift
//  MRN Coordinator
//
//  Created by Margarita Slesareva on 05.11.2023.
//

import UIKit

protocol WelcomeScreenOutput: AnyObject {
    
}

final class AppCoordinator: BaseCoordinator {
    
    func start() {
        showLogin()
    }
}

extension AppCoordinator: WelcomeScreenOutput {
    
    func showLogin() {
        let loadingCoordinator = LoadingCoordinator(router: router)
        loadingCoordinator.start()
        loadingCoordinator.onFinish = { [weak self] in
            self?.removeDependency(loadingCoordinator)
            self?.showDemo()
        }
        addDependency(loadingCoordinator)
    }

    func showDemo() {
        let tabBarCoordinator = TabBarCoordinator(router: router)
        tabBarCoordinator.start()
        tabBarCoordinator.onFinish = { [weak self] in
            self?.removeDependency(tabBarCoordinator)
        }
        addDependency(tabBarCoordinator)
    }
}
