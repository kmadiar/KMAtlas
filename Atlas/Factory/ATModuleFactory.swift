//
//  ATModuleFactory.swift
//  Atlas
//
//  Created by Kostiantyn Madiar on 12/26/18.
//  Copyright © 2018 Kostiantyn Madiar. All rights reserved.
//

protocol ATModuleFactory {
    func makeRegions(dataService: ATDataService) -> RegionsListView
    func makeCoutryList(dataService: ATDataService, param: CountryListParam) -> CountryListView
    func makeCountryDetails(details: CountryDetails) -> CountryDetailView
    func makeSearchOutput(dataService: ATDataService) -> SearchListView
}
