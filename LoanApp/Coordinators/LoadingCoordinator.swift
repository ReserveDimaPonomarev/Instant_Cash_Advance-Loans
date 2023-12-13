//
//  LoadingCoordinator.swift
//  LoanApp
//
//  Created by Дмитрий Пономарев on 30.11.2023.
//

import Foundation

protocol LoginOutput: AnyObject {
    func showFirstScreen()
    func showSecondScreen()
    func showThirdScreen()
    func showMainScreen()
}

final class LoadingCoordinator: BaseCoordinator {
    
    var onFinish: (() -> Void)?
    
    var userData: UserData?
    var factoryLoading: LoadingFactoryProtocol!

    func start() {
        showLoadingScreen()
    }
    
    func finish() {
        onFinish?()
    }
}

extension LoadingCoordinator: LoginOutput {
    
    func showLoadingScreen() {
        let loadingVC = factoryLoading.createLoadingScreen(coordinator: self)
        
        router.push(loadingVC)
    }
    
    func showFirstScreen() {
        let firstVC = factoryLoading.createFirstScreen(coordinator: self)
        
        router.push(firstVC)
    }
    
    func showSecondScreen() {
        let secondVC = factoryLoading.createSecondScreen(coordinator: self)

        router.push(secondVC)
    }
    
    func showThirdScreen() {
        let thirdVC = factoryLoading.createThirdScreen(coordinator: self)
        thirdVC.complitionHandler = { [weak self] userData in
            guard let self else { return }
            self.userData = userData
        }
        router.push(thirdVC)

    }
    
    func showMainScreen() {
        finish()
    }
}
