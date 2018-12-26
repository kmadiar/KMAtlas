//
//  ATCoordinatorFactoryImp.swift
//  Atlas
//
//  Created by Kostiantyn Madiar on 12/26/18.
//  Copyright © 2018 Kostiantyn Madiar. All rights reserved.
//
import UIKit

final class ATCoordinatorFactoryImp: ATCoordinatorFactory {
    func makeTabbarCoordinatorBox() -> (coordinator: ATCoordinator, toPresent: ATPresentable?) {
        let controller = MainTabBarController.atlas_controllerFromStoryboard(.main)
        let coordinator = ATTabbarCoordinator(tabbarView: controller, coordinatorFactory: ATCoordinatorFactoryImp())
        return (coordinator, controller)
    }
    
    func makeAtlasCoordinator(navController: UINavigationController?) -> ATCoordinator {
        let controller = MainTabBarController.atlas_controllerFromStoryboard(.main)
        let coordinator = ATTabbarCoordinator(tabbarView: controller, coordinatorFactory: ATCoordinatorFactoryImp())
        return coordinator
    }
    
    func makeSearchCoordinator(navController: UINavigationController?) -> ATCoordinator {
        let controller = MainTabBarController.atlas_controllerFromStoryboard(.main)
        let coordinator = ATTabbarCoordinator(tabbarView: controller, coordinatorFactory: ATCoordinatorFactoryImp())
        return coordinator
    }
    
    func makeFavoritesCoordinator(navController: UINavigationController?) -> ATCoordinator {
        let controller = MainTabBarController.atlas_controllerFromStoryboard(.main)
        let coordinator = ATTabbarCoordinator(tabbarView: controller, coordinatorFactory: ATCoordinatorFactoryImp())
        return coordinator
    }
}
