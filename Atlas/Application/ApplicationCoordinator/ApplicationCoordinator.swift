//
//  ApplicationCoordinator.swift
//  Atlas
//
//  Created by Kostiantyn Madiar on 12/26/18.
//  Copyright © 2018 Kostiantyn Madiar. All rights reserved.
//

import UIKit

class ApplicationCoordinator: ATBaseCoordinator {
    
    public var dataService: ATDataService!
    
    private let coordinatorFactory: ATCoordinatorFactory
    private let router: ATRouter
    
    init(router: ATRouter, coordinatorFactory: ATCoordinatorFactory) {
        self.router = router
        self.coordinatorFactory = coordinatorFactory
    }
    
    override func start() {
        runMainFlow()
    }
    
    func runMainFlow() {
        let (coordinator, module) = coordinatorFactory.makeTabbarCoordinatorBox()
        addDependency(coordinator)
        router.setRootModule(module, hideBar: true)
        coordinator.start()
    }
}
