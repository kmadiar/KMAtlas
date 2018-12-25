//
//  ATDataService.swift
//  Atlas
//
//  Created by Kostiantyn Madiar on 12/26/18.
//  Copyright © 2018 Kostiantyn Madiar. All rights reserved.
//

import Foundation

protocol ATDataService {
    func getRegions(completion: @escaping (ATResult<[ATRegion], ATAPIError>) -> ()) -> [ATRegion]
    func getRegionGroups(completion: @escaping (ATResult<[ATRegionGroup], ATAPIError>) -> ()) -> [ATRegionGroup]
    func getCountries(by name: String?, completion: @escaping (ATResult<[ATCountry], ATAPIError>) -> ()) -> [ATCountry]
    func getCountries(by region: ATRegion, completion: @escaping (ATResult<[ATCountry], ATAPIError>) -> ()) -> [ATCountry]
    func getCountries(by regionGroup: ATRegionGroup, completion: @escaping (ATResult<[ATCountry], ATAPIError>) -> ()) -> [ATCountry]
}
