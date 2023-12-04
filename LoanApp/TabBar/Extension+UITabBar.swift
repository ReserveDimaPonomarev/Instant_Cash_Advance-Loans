//
//  Extension+UITabBar.swift
//  LoanApp
//
//  Created by Дмитрий Пономарев on 30.11.2023.
//

import UIKit

extension UITabBarItem {
    
    func setupTabBarItem(image: ImageResource, text: String) -> UITabBarItem {
        
        let inactiveIconImage = UIImage(resource: image).withRenderingMode(.alwaysOriginal)
        let activeIconImage = UIImage(resource: image).withRenderingMode(.alwaysOriginal)

        let resizedInactiveIcon = inactiveIconImage.preparingThumbnail(of: CGSize.init(width: 25, height: 25))
        let resizedActiveIcon = activeIconImage.preparingThumbnail(of: CGSize.init(width: 32, height: 32))
        
        let productsTabBarItem = UITabBarItem(
            title: text,
            image: resizedInactiveIcon,
            selectedImage: resizedActiveIcon
        )
        
        productsTabBarItem.setTitleTextAttributes([.font: UIFont.systemFont(ofSize: 16, weight: .semibold), .foregroundColor: UIColor.blue], for: .normal)
        productsTabBarItem.image?.withTintColor(.black, renderingMode: .alwaysTemplate)
        return productsTabBarItem
    }
}
