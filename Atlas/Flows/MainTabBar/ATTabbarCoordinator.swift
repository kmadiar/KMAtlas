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
    var atlasCoordinator: AtlasCoordinator!
    private func runAtlasFlow() -> ((UINavigationController) -> ()) {
        return { [unowned self] navController in
            if navController.viewControllers.isEmpty == true {
                self.atlasCoordinator = self.coordinatorFactory.makeAtlasCoordinator(navController: navController) as! AtlasCoordinator
                self.addDependency(self.atlasCoordinator)
                self.atlasCoordinator.start()
            }
            self.atlasCoordinator.clean()
        }
    }
    var searchCoordinator: SearchCoordinator!
    private func runSearchFlow() -> ((UINavigationController) -> ()) {
        return { [unowned self] navController in
            if navController.viewControllers.isEmpty == true {
                self.searchCoordinator = self.coordinatorFactory.makeSearchCoordinator(navController: navController) as! SearchCoordinator
                self.addDependency(self.searchCoordinator)
                self.searchCoordinator.start()
            }
            self.searchCoordinator.clean()
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
