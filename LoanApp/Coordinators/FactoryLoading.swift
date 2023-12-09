//
//  FactoryLoading.swift
//  LoanApp
//
//  Created by Дмитрий Пономарев on 09.12.2023.
//

import Foundation

class FactoryLoading {
    
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
