//
//  MainTabBarViewController.swift
//  Atlas
//
//  Created by Kostiantyn Madiar on 12/26/18.
//  Copyright © 2018 Kostiantyn Madiar. All rights reserved.
//

import UIKit

final class MainTabBarController: UITabBarController, UITabBarControllerDelegate, ATTabbarView {
    
    var onAtlasFlowSelect: ((UINavigationController) -> ())?
    var onSearchFlowSelect: ((UINavigationController) -> ())?
    var onFavoritesFlowSelect: ((UINavigationController) -> ())?
    var onViewDidLoad: ((UINavigationController) -> ())?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        delegate = self
        if let controller = customizableViewControllers?.first as? UINavigationController {
            onViewDidLoad?(controller)
        }
    }
    
    func tabBarController(_ tabBarController: UITabBarController, didSelect viewController: UIViewController) {
        guard let controller = viewControllers?[selectedIndex] as? UINavigationController else { return }
        if selectedIndex == 0 {
            onAtlasFlowSelect?(controller)
        }
        else if selectedIndex == 1 {
            onSearchFlowSelect?(controller)
        }
        else if selectedIndex == 2 {
            onFavoritesFlowSelect?(controller)
        }
    }
}
