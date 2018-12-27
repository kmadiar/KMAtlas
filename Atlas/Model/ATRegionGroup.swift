//
//  ATRegionGroup.swift
//  Atlas
//
//  Created by Kostiantyn Madiar on 12/25/18.
//  Copyright © 2018 Kostiantyn Madiar. All rights reserved.
//

import Foundation

private typealias Texts = ATTextConstants.ATRegionGroup

enum ATRegionGroup: String, Decodable {
    case eu, efta, caricom, pa, au, usan, eeu, al, asean, cais, cefta, nafta, saarc
    
    func title() -> String {
        switch self {
        case .eu:
            return Texts.eu
        case .efta:
            return Texts.efta
        case .caricom:
            return Texts.caricom
        case .pa:
            return Texts.pa
        case .au:
            return Texts.au
        case .usan:
            return Texts.usan
        case .eeu:
            return Texts.eeu
        case .al:
            return Texts.al
        case .asean:
            return Texts.asean
        case .cais:
            return Texts.cais
        case .cefta:
            return Texts.cefta
        case .nafta:
            return Texts.nafta
        case .saarc:
            return Texts.saarc
        }
    }
    
    private enum CodingKeys : String, CodingKey {
        case acronym = "acronym"
    }
    
    enum ATRegionGroupCodingError: Error {
        case decoding(String)
    }
    
    init(from decoder: Decoder) throws {
        let keys = try decoder.container(keyedBy: CodingKeys.self)//.decode(String.self)
        if let acronymValue = try? keys.decode(String.self, forKey: .acronym).lowercased(), let regionGroup = ATRegionGroup(rawValue: acronymValue) {
            self = regionGroup
            return
        }
        
        throw ATRegionGroupCodingError.decoding("Whoops! \(dump(keys))")
    }
}
