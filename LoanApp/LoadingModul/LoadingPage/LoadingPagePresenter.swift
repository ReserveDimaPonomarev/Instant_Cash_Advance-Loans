//
//  LoadingPagePresenter.swift
//  LoanApp
//
//  Created by Дмитрий Пономарев on 30.11.2023.
//


import Foundation

protocol LoadingPagePresenterProtocol: AnyObject {
    var controller: LoadingPageDisplayLogic? { get set }
    func progressHasBeenCompleted()
}

class LoadingPagePresenter {
    
    //  MARK: - External properties
    
    weak var controller: LoadingPageDisplayLogic?
    
    //  MARK: Data Variables
    
    
    // MARK: Private Variables
    
    private weak var coordinator: (LoginOutput)?
    
    //  MARK: - Init
    
    init(coordinator: LoginOutput) {
        self.coordinator = coordinator
    }
    
    //  MARK: - Delegate methodes
    
    
    
    //  MARK: - Private Methods
    
}

//  MARK: - extension LoadingPagePresenterProtocol

extension LoadingPagePresenter: LoadingPagePresenterProtocol {
    func progressHasBeenCompleted() {
        coordinator?.showFirstScreen()
    }
}
