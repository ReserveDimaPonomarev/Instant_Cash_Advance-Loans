//
//  AppCoordinator.swift
//  MRN Coordinator
//
//  Created by Margarita Slesareva on 05.11.2023.
//

import UIKit


final class AppCoordinator: BaseCoordinator {
    
    func start() {
        showLoadingCoordinator()
    }
}

extension AppCoordinator {
    
    func showLoadingCoordinator() {
        let loadingCoordinator = LoadingCoordinator(router: router)
        loadingCoordinator.start()
        loadingCoordinator.onFinish = { [weak self] in
            self?.removeDependency(loadingCoordinator)
            self?.showTabBarCoordinator()
        }
        addDependency(loadingCoordinator)
    }

    func showTabBarCoordinator() {
        let tabBarCoordinator = TabBarCoordinator(router: router)
        tabBarCoordinator.start()
        tabBarCoordinator.onFinish = { [weak self] in
            self?.removeDependency(tabBarCoordinator)
        }
        addDependency(tabBarCoordinator)
    }
}
