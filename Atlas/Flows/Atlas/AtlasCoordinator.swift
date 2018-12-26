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
            let params: CountryListParam
            if item.group {
                params = CountryListParam(name: item.name, regionId: nil, regionGroupId: item.code)
            } else {
                params = CountryListParam(name: item.name, regionId: item.code, regionGroupId: nil)
            }
            
            self?.showCountryList(params)
        }
        router.setRootModule(itemsOutput)
    }

    func showCountryList(_ params: CountryListParam) {
        let countryListOutput = factory.makeCoutryList(dataService: dataService, param: params)
        router.push(countryListOutput)
    }
    
//    private func showItemDetail(_ item: RegionsListItem) {
//        let itemDetailFlowOutput = factory.makeCoutryList(dataService: dataService, param: item)
//        router.push(itemDetailFlowOutput)
//    }
}
