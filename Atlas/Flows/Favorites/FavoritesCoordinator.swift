//
//  FavoritesCoordinator.swift
//  Atlas
//
//  Created by Kostiantyn Madiar on 12/27/18.
//  Copyright © 2018 Kostiantyn Madiar. All rights reserved.
//

import Foundation

final class FavoritesCoordinator: ATBaseCoordinator {
    
    private let factory: ATModuleFactory
    private let router: ATRouter
    private let dataService: ATDataService
    
    init(router: ATRouter, factory: ATModuleFactory, dataService: ATDataService) {
        self.router = router
        self.factory = factory
        self.dataService = dataService
    }
    
    override func start() {
        showFavorieList()
    }
    
    //MARK: - Run current flow's controllers
    private func showFavorieList() {
        let searchOutput = factory.makeFavoritesOutput(dataService: dataService)
        router.setRootModule(searchOutput)
    }
}
