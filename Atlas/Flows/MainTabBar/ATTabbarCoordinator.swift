//
//  ATTabbarCoordinator.swift
//  Atlas
//
//  Created by Kostiantyn Madiar on 12/26/18.
//  Copyright © 2018 Kostiantyn Madiar. All rights reserved.
//
import UIKit

class ATTabbarCoordinator: ATBaseCoordinator {
    
    private let tabbarView: ATTabbarView
    private let coordinatorFactory: ATCoordinatorFactory
    
    init(tabbarView: ATTabbarView, coordinatorFactory: ATCoordinatorFactory) {
        self.tabbarView = tabbarView
        self.coordinatorFactory = coordinatorFactory
    }
    
    override func start() {
        tabbarView.onViewDidLoad = runAtlasFlow()
        tabbarView.onAtlasFlowSelect = runAtlasFlow()
        tabbarView.onSearchFlowSelect = runSearchFlow()
        tabbarView.onFavoritesFlowSelect = runFavoritesFlow()
    }
    
    private func runAtlasFlow() -> ((UINavigationController) -> ()) {
        return { [unowned self] navController in
            if navController.viewControllers.isEmpty == true {
                let atlasCoordinator = self.coordinatorFactory.makeAtlasCoordinator(navController: navController)
                self.addDependency(atlasCoordinator)
                atlasCoordinator.start()
            }
        }
    }
    
    private func runSearchFlow() -> ((UINavigationController) -> ()) {
        return { [unowned self] navController in
            if navController.viewControllers.isEmpty == true {
                let searchCoordinator = self.coordinatorFactory.makeSearchCoordinator(navController: navController)
                self.addDependency(searchCoordinator)
                searchCoordinator.start()
            }
        }
    }
    
    private func runFavoritesFlow() -> ((UINavigationController) -> ()) {
        return { [unowned self] navController in
            if navController.viewControllers.isEmpty == true {
                let favoritesCoordinator = self.coordinatorFactory.makeFavoritesCoordinator(navController: navController)
                self.addDependency(favoritesCoordinator)
                favoritesCoordinator.start()
            }
        }
    }
}
