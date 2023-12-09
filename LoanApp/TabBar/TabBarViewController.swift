//
//  TabBarViewController.swift
//  LoanApp
//
//  Created by Дмитрий Пономарев on 30.11.2023.
//

import UIKit

final class TabBarViewController: UITabBarController, UITabBarControllerDelegate {
    
    //  MARK: External dependencies
    
    weak var tabBarDelegate: UITabBarDelegate?
    
    //  MARK: - life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    override func viewWillAppear(_ animated: Bool) {
        self.selectedIndex = 1
    }
    
    func switchToFirstTab() {
        let registerationPageIndex = 1
        self.viewControllers?[registerationPageIndex].removeFromParent()
    }
}

//  MARK: - private methods

private extension TabBarViewController {
    
    //  MARK: - setup UI
    
    private func setupUI() {
        tabBar.tintColor = .black
        tabBar.unselectedItemTintColor = .black
        tabBar.backgroundColor = .white
        self.delegate = self
        self.tabBarDelegate = self
    }
}
