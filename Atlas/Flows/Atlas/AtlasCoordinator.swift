//
//  AtlasCoordinator.swift
//  Atlas
//
//  Created by Kostiantyn Madiar on 12/26/18.
//  Copyright © 2018 Kostiantyn Madiar. All rights reserved.
//

import Foundation

final class AtlasCoordinator: ATBaseCoordinator {
    
    private let factory: ATModuleFactory
    private let router: ATRouter
    private let dataService: ATDataService
    
    init(router: ATRouter, factory: ATModuleFactory, dataService: ATDataService) {
        self.router = router
        self.factory = factory
        self.dataService = dataService
    }
    
    override func start() {
        showRegionList()
    }
    
    //MARK: - Run current flow's controllers
    
    private func showRegionList() {
        
        let itemsOutput = factory.makeRegions(dataService: dataService)
        itemsOutput.onItemSelect = { [weak self] (item) in
            self?.showItemDetail(item)
        }
        router.setRootModule(itemsOutput)
    }
    
    private func showItemDetail(_ item: RegionsListItem) {
        
//        let itemDetailFlowOutput = factory.makeItemDetailOutput(item: item)
//        router.push(itemDetailFlowOutput)
    }
}
