//
//  ATDataManager.swift
//  Atlas
//
//  Created by Kostiantyn Madiar on 12/26/18.
//  Copyright © 2018 Kostiantyn Madiar. All rights reserved.
//

import Foundation

class ATNetworkDataManager: ATDataService {
    func getCountry_alpha3(by alpha3Code: String) -> ATCountry? {
        return currentCountries().first(where: { $0.alpha3Code == alpha3Code })
    }
    
    func getCountry(by name: String) -> ATCountry? {
        return currentCountries().first(where: { $0.name == name })
    }
    
    func refreshData() {
        getAll { [weak self] (result) in
            guard let strongSelf = self else { return }
            switch result {
            case .success(let countries):
                strongSelf.setCountries(countries)
            case .failure:
                break
            }
        }
    }
    
    func getRegions(completion: @escaping (ATResult<[ATRegion], ATAPIError>) -> ()) -> [ATRegion] {
        let countries = currentCountries()
        if countries.count == 0 {
            getAll { [weak self] (result) in
                guard let strongSelf = self else { return }
                switch result {
                case .success(let countries):
                    strongSelf.setCountries(countries)
                    completion(.success(strongSelf.getRegions(countries: strongSelf.currentCountries())))
                case .failure(let error):
                    completion(.failure(error))
                }
            }
        }
        return getRegions(countries: countries)
    }
    
    func getRegionGroups(completion: @escaping (ATResult<[ATRegionGroup], ATAPIError>) -> ()) -> [ATRegionGroup] {
        let countries = currentCountries()
        if countries.count == 0 {
            getAll { [weak self] (result) in
                guard let strongSelf = self else { return }
                switch result {
                case .success(let countries):
                    strongSelf.setCountries(countries)
                    completion(.success(strongSelf.getRegionGroups(countries: strongSelf.currentCountries())))
                case .failure(let error):
                    completion(.failure(error))
                }
            }
        }
        return getRegionGroups(countries: countries)
    }
    
    func getCountries(by name: String?, completion: @escaping (ATResult<[ATCountry], ATAPIError>) -> ()) -> [ATCountry] {
        let countries = currentCountries()
        return countries.filter({ $0.name.hasPrefix(name ?? "") })
    }
    
    func getCountries(by region: ATRegion, completion: @escaping (ATResult<[ATCountry], ATAPIError>) -> ()) -> [ATCountry] {
        let countries = currentCountries()
        return countries.filter({ $0.region == region })
    }
    
    func getCountries(by regionGroup: ATRegionGroup, completion: @escaping (ATResult<[ATCountry], ATAPIError>) -> ()) -> [ATCountry] {
        let countries = currentCountries()
        return countries.filter({ $0.regionalBlocs.contains(regionGroup) })
    }
    


    private func getRegions(countries: [ATCountry]) -> [ATRegion] {
        return countries.map({ $0.region }).unique
    }
    
    private func getRegionGroups(countries: [ATCountry]) -> [ATRegionGroup] {
        return countries.map({ $0.regionalBlocs }).flatMap({ $0 }).unique
    }
    
    private func getAll(completion: @escaping (ATResult<[ATCountry], ATAPIError>) -> ()) {
        ATHTTPClient().get([ATCountry].self, completion: completion)
    }
    
    private var _countries: [ATCountry] = []
    private let concurrentCoutriesQueue =
        DispatchQueue(
            label: "com.test.concurrentCoutriesQueue",
            attributes: .concurrent)
    
    private func currentCountries() -> [ATCountry] {
        var items: [ATCountry] = []
        concurrentCoutriesQueue.sync {
            items = _countries
        }
        return items
    }
    
    private func setCountries(_ countries: [ATCountry]) {
        var c = countries
        for (index, country) in countries.enumerated() {
            c[index].flag = ATFlagHelper.emoji(by: country.alpha2Code)
        }
        concurrentCoutriesQueue.async(flags: .barrier) { [weak self] in
            guard let strongSelf = self else { return }
            strongSelf._countries = c
        }
    }
}
