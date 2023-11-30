//
//  LoadingCoordinator.swift
//  LoanApp
//
//  Created by Дмитрий Пономарев on 30.11.2023.
//

import Foundation

//
//  LoginCoordinator.swift
//  BettaBank
//
//  Created by Margarita Slesareva on 14.11.2023.
//

protocol LoginOutput {
    func showFirstScreen()
    func showSecondScreen()
    func showThirdScreen()
    func showMainScreen()
}

final class LoadingCoordinator: BaseCoordinator {
    var onFinish: (() -> Void)?
    
    func start() {
        showFirstScreen()
    }
    
    func finish() {
        onFinish?()
    }
}

extension LoadingCoordinator: LoginOutput {
    
    func showFirstScreen() {
        let firstVC = FirstViewController()
        firstVC.loginOutput = self
        
        router.push(firstVC)
    }
    
    func showSecondScreen() {
        let secondVC = SecondViewController()
        secondVC.loginOutput = self

        router.push(secondVC)
    }
    
    func showThirdScreen() {
        let thirdVC = ThirdViewController()
        thirdVC.loginOutput = self

        router.push(thirdVC)
    }
    
    func showMainScreen() {
        finish()
    }
}
