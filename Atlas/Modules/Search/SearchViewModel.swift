//
//  SearchViewModel.swift
//  Atlas
//
//  Created by Kostiantyn Madiar on 12/27/18.
//  Copyright © 2018 Kostiantyn Madiar. All rights reserved.
//

import RxSwift
import RxCocoa

class SearchViewModel {
    
    let searchText = BehaviorRelay(value: "")
    
    lazy var data: Driver<[CountryListItem]> = {
        
        return self.searchText.asObservable()
            .throttle(0.3, scheduler: MainScheduler.instance)
            .distinctUntilChanged()
            .flatMapLatest(SearchViewModel.repositoriesBy)
            .asDriver(onErrorJustReturn: [])
    }()
    
    static func repositoriesBy(_ countryName: String) -> Observable<[CountryListItem]> {
        
        guard !countryName.isEmpty,
            let url = URL(string: "https://restcountries.eu/rest/v2/name/\(countryName)") else {
                return Observable.just([])
        }
        
        return URLSession.shared.rx.data(request: URLRequest(url: url))
            .retry(3)
            .catchErrorJustReturn(Data())
            .map(parse)
    }
    
    static func parse(data: Data) -> [CountryListItem] {
        var countries: [ATCountry] = []
        do {
            let decoder = JSONDecoder()
            decoder.keyDecodingStrategy = .convertFromSnakeCase
            countries = try decoder.decode([ATCountry].self, from: data)
        } catch {
            print(error)
        }
        
        for (index, var country) in countries.enumerated() {
            country.flag = ATFlagHelper.emoji(by: country.alpha2Code)
            countries[index] = country
        }
        
        return countries.map({ CountryListItem(countryFlag: $0.flag, name: $0.name, nativeName: $0.nativeName) })
    }
}
