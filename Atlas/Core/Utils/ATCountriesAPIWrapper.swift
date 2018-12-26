//
//  ATCountriesAPIWrapper.swift
//  Atlas
//
//  Created by Kostiantyn Madiar on 12/25/18.
//  Copyright © 2018 Kostiantyn Madiar. All rights reserved.
//

import Foundation

enum ATCountriesAPIEnpoint {
    
    case all
    case name(query: String?)
}

extension ATCountriesAPIEnpoint: Endpoint {
    
    var base: String {
        return "https://restcountries.eu"
    }
    
    var path: String {
        switch self {
        case .all:
            return "/rest/v2/all"
        case .name(let query):
            return "/rest/v2/name/\(query ?? "")"
        }
    }
    
    var queryItems: [URLQueryItem] {
        return []
    }
    
    init?(T: Decodable.Type, query: String?) {
        switch T {
        case is Array<ATCountry>.Type:
            if let q = query {
                self = .name(query: q)
            } else {
                self = .all
            }
        default:
            return nil
        }
        
    }
}
