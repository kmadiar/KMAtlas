//
//  ATCountry.swift
//  Atlas
//
//  Created by Kostiantyn Madiar on 12/25/18.
//  Copyright © 2018 Kostiantyn Madiar. All rights reserved.
//

import Foundation

struct ATCountry: Decodable {
    var name: String // Country name
    var region: ATRegion // Country Region
    var regionalBlocs: [ATRegionGroup] // Contry region blocks
    var nativeName: String // Name on native language
    var currencies: [ATCurrency]
    var languages: [ATLanguage]
    var latlng: [Double]
    var alpha3Code: String
    var alpha2Code: String
    
    var flag: String
//
    var borders: [String]
}

//{
//    "name":"Andorra",
//    "alpha3Code":"AND",
//    "region":"Europe",
//    "latlng":[
//      42.5,
//      1.5
//    ],
//    "borders":[
//      "FRA",
//      "ESP"
//    ],
//    "nativeName":"Andorra",
//    "currencies":[
//      {
//          "code":"EUR",
//          "name":"Euro",
//          "symbol":"€"
//      }
//    ],
//    "languages":[
//      {
//          "iso639_1":"ca",
//          "iso639_2":"cat",
//          "name":"Catalan",
//          "nativeName":"català"
//      }
//    ],
//    "regionalBlocs":[
//    
//    ]
//}
