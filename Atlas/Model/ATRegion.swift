//
//  ATRegion.swift
//  Atlas
//
//  Created by Kostiantyn Madiar on 12/25/18.
//  Copyright © 2018 Kostiantyn Madiar. All rights reserved.
//

import Foundation

private typealias Texts = ATTextConstants.ATRegion

enum ATRegion: String, Decodable {
    case africa, americas, asia, europe, oceania, polar, undefined = ""
    
    func title() -> String {
        switch self {
        case .africa:
            return Texts.africa
        case .americas:
            return Texts.americas
        case .asia:
            return Texts.asia
        case .europe:
            return Texts.europe
        case .oceania:
            return Texts.oceania
        case .polar:
            return Texts.polar
        case .undefined:
            return Texts.undefined
        }
    }
    
    enum ATRegionCodingError: Error {
        case decoding(String)
    }
    
    init(from decoder: Decoder) throws {
        let value = try decoder.singleValueContainer().decode(String.self).lowercased()
        if let region = ATRegion(rawValue: value) {
            self = region
            return
        }
        
        throw ATRegionCodingError.decoding("Whoops! \(dump(value))")
    }
}
