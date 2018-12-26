//
//  SearchCoordinator.swift
//  Atlas
//
//  Created by Kostiantyn Madiar on 12/27/18.
//  Copyright © 2018 Kostiantyn Madiar. All rights reserved.
//

import Foundation

final class SearchCoordinator: ATBaseCoordinator {
    
    private let factory: ATModuleFactory
    private let router: ATRouter
    private let dataService: ATDataService
    
    init(router: ATRouter, factory: ATModuleFactory, dataService: ATDataService) {
        self.router = router
        self.factory = factory
        self.dataService = dataService
    }
    
    override func start() {
        showSearchList()
    }
    
    //MARK: - Run current flow's controllers
    
    private func showSearchList() {
        let searchOutput = factory.makeSearchOutput(dataService: dataService)
        searchOutput.onItemSelect = showDetails
        router.setRootModule(searchOutput)
    }
 
    func showCountryDetails(_ details: CountryDetails) {
        let countryDetailsOutput = factory.makeCountryDetails(details: details)
        countryDetailsOutput.onItemSelect = showDetails
        router.push(countryDetailsOutput)
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
            
            strongSelf.showCountryDetails(details)
        }
    }
}
