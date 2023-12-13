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
        loadingCoordinator.factoryLoading = ScreenFactory()
        loadingCoordinator.start()
        loadingCoordinator.onFinish = { [weak self] in
            guard let self else { return }
            self.showTabBarCoordinator(userData: loadingCoordinator.userData)
            self.removeDependency(loadingCoordinator)
            
        }
        addDependency(loadingCoordinator)
    }

    func showTabBarCoordinator(userData: UserData?) {
        let tabBarCoordinator = TabBarCoordinator(router: router)
        tabBarCoordinator.userData = userData
        tabBarCoordinator.start()
        tabBarCoordinator.onFinish = { [weak self] in
            guard let self else { return }
            self.removeDependency(tabBarCoordinator)
        }
        addDependency(tabBarCoordinator)
    }
}
