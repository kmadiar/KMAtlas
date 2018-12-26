//
//  ATCoordinatorFactoryImp.swift
//  Atlas
//
//  Created by Kostiantyn Madiar on 12/26/18.
//  Copyright © 2018 Kostiantyn Madiar. All rights reserved.
//
import UIKit

final class ATCoordinatorFactoryImp: ATCoordinatorFactory {
    
    private let dataService: ATDataService
    
    init(dataService: ATDataService) {
        self.dataService = dataService
    }
    
    func makeTabbarCoordinatorBox() -> (coordinator: ATCoordinator, toPresent: ATPresentable?) {
        let controller = MainTabBarController.atlas_controllerFromStoryboard(.main)
        let coordinator = ATTabbarCoordinator(tabbarView: controller, coordinatorFactory: ATCoordinatorFactoryImp(dataService: dataService))
        return (coordinator, controller)
    }
    
    func makeAtlasCoordinator(navController: UINavigationController?) -> ATCoordinator {
        let coordinator = AtlasCoordinator(
            router: router(navController),
            factory: ATModuleFactoryImp(), dataService: dataService
        )
        return coordinator
    }
    
    func makeSearchCoordinator(navController: UINavigationController?) -> ATCoordinator {
        let controller = MainTabBarController.atlas_controllerFromStoryboard(.main)
        let coordinator = ATTabbarCoordinator(tabbarView: controller, coordinatorFactory: ATCoordinatorFactoryImp(dataService: dataService))
        return coordinator
    }
    
    func makeFavoritesCoordinator(navController: UINavigationController?) -> ATCoordinator {
        let controller = MainTabBarController.atlas_controllerFromStoryboard(.main)
        let coordinator = ATTabbarCoordinator(tabbarView: controller, coordinatorFactory: ATCoordinatorFactoryImp(dataService: dataService))
        return coordinator
    }
    
    private func router(_ navController: UINavigationController?) -> ATRouter {
        return ATRouterImp(rootController: navigationController(navController))
    }
    
    private func navigationController(_ navController: UINavigationController?) -> UINavigationController {
        if let navController = navController { return navController }
        else { return UINavigationController.atlas_controllerFromStoryboard(.main) }
    }
}
