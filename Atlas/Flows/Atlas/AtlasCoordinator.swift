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
        countryListOutput.onItemSelect = showDetails
        router.push(countryListOutput)
    }
    
    // TODO extract separate coordinator
    // begin
    func clean() {
        stack.removeAll()
        left = nil
        current = nil
        right = nil
    }
    
    func showCountryDetails(_ details: CountryDetails) {
        if stack.count == 1 {
            let countryDetailsOutput = factory.makeCountryDetails(details: details)
            countryDetailsOutput.onItemSelect = showDetails
            router.push(countryDetailsOutput)
        } else {
            pushModule(details: details)
        }
    }
    
    private var stack: [CountryDetails] = []
    private var left: CountryDetailView?
    private var current: CountryDetailView?
    private var right: CountryDetailView?
    
    private func pushModule(details: CountryDetails) {
        //prepare next module
        if right == nil {
            right = factory.makeCountryDetails(details: details)
            right!.onItemSelect = showDetails
            right!.onBack = { [weak self] in
                self?.popModule()
            }
        } else {
            right?.details = details
        }
        // switch modules
        router.push(right)
        
        let tmp = left
        left = current
        current = right
        right = tmp
        
        if stack.count > 2 {
            router.removeFromStack(right)
        }
    }
    
    private func popModule() {
        guard !stack.isEmpty else { return }
        _ = stack.removeLast()
        
        let tmp = current
        current = left
        left = right
        right = tmp
        left?.details = stack[stack.count-1]
        if stack.count > 2 {
            router.insert(module: right, before: current)
        }
    }
    
    lazy var showDetails: ((CountryListItem) -> ()) = { [weak self] item in
        guard let strongSelf = self else { return }

        if let c = strongSelf.dataService.getCountry(by: item.name) {
            let joiner = ", "
            let currencies = c.currencies.compactMap({ $0.name }).joined(separator: joiner)
            let languages = c.languages.compactMap({ $0.name }).joined(separator: joiner)
            var items: [CountryListItem] = []
            for border in c.borders {
                if let resultCountry = strongSelf.dataService.getCountry_alpha3(by: border) {
                    items.append(CountryListItem(countryFlag: resultCountry.flag, name: resultCountry.name, nativeName: resultCountry.nativeName) )
                }
            }
            
            let details = CountryDetails(name: c.name, flag: c.flag, currency: currencies, languages: languages, location: c.latlng, items: items)
            strongSelf.stack.append(details)
            strongSelf.showCountryDetails(details)
        }
    }
    
    // end
    // TODO
}
