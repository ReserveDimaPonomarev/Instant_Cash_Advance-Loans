//
//  TabBarViewController.swift
//  LoanApp
//
//  Created by Дмитрий Пономарев on 30.11.2023.
//

import UIKit



final class TabBarViewController: UITabBarController, UITabBarControllerDelegate {
    
    weak var tabBarDelegate: UITabBarDelegate?
    
    var myColsure: ((UINavigationController)->Void)?
    
    //  MARK: - life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    //  MARK: - setup UI
    
    private func setupUI() {
        tabBar.tintColor = .black
        tabBar.unselectedItemTintColor = .black
        tabBar.backgroundColor = .white
        self.delegate = self
        self.tabBarDelegate = self
    }

    func switchToFirstTab() {
        let mainPageIndex = 0
        let registerationPageIndex = 1
        self.viewControllers?[registerationPageIndex].removeFromParent()
        
        if mainPageIndex < viewControllers?.count ?? 0 {
            selectedIndex = mainPageIndex
            if let selectedViewController = selectedViewController {
                selectedViewController.viewWillAppear(true)
            }
        }
        
    }
}
