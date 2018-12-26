//
//  ATModuleFactoryImp.swift
//  Atlas
//
//  Created by Kostiantyn Madiar on 12/26/18.
//  Copyright © 2018 Kostiantyn Madiar. All rights reserved.
//

final class ATModuleFactoryImp: ATModuleFactory {
    func makeCountryDetails(details: CountryDetails) -> CountryDetailView {
        let vc = CountryDetailController.atlas_controllerFromStoryboard(.country)
        vc.details = details
        
        return vc
    }
    
    func makeCoutryList(dataService: ATDataService, param: CountryListParam) -> CountryListView {
        let vc = CountryListController.atlas_controllerFromStoryboard(.countries)
        vc.dataService = dataService
        vc.params = param
        return vc
    }
    
    func makeRegions(dataService: ATDataService) -> RegionsListView {
        let vc = RegionsListController.atlas_controllerFromStoryboard(.regions)
        vc.dataService = dataService
        
        return vc
    }
}
