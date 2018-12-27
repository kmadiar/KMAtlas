//
//  ATAPIError.swift
//  Atlas
//
//  Created by Kostiantyn Madiar on 12/25/18.
//  Copyright © 2018 Kostiantyn Madiar. All rights reserved.
//

import Foundation

enum ATAPIError: Error {
    
    case requestFailed(description: String)
    case jsonConversionFailure(description: String)
    case invalidData
    case responseUnsuccessful(description: String)
    case jsonParsingFailure
    
    var customDescription: String {
        switch self {
        case .requestFailed(let desc): return "Request Failed error -> \(desc)"
        case .invalidData: return "Invalid Data error)"
        case .responseUnsuccessful(let desc): return "Response Unsuccessful error -> \(desc)"
        case .jsonParsingFailure: return "JSON Parsing Failure error)"
        case .jsonConversionFailure(let desc): return "JSON Conversion Failure -> \(desc)"
        }
    }
}
