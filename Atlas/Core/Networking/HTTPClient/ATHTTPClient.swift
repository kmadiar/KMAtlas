//
//  ATHTTPClient.swift
//  Atlas
//
//  Created by Kostiantyn Madiar on 12/25/18.
//  Copyright © 2018 Kostiantyn Madiar. All rights reserved.
//

import Foundation
class ATHTTPClient: ATHTTPClientProtocol {
    
    var session: URLSession
    
    init(configuration: URLSessionConfiguration) {
        self.session = URLSession(configuration: configuration)
    }
    
    public convenience init() {
        self.init(configuration: .default)
    }
    
    private func fetch<T: Decodable>(with request: URLRequest, completion: @escaping (ATResult<T, ATAPIError>) -> Void) {
        fetchAndDecodeJSON(with: request, decodingType: T.self, completionHandler: completion)
    }
    
    public func get<T: Decodable>(_ value: T.Type, completion: @escaping (ATResult<T, ATAPIError>) -> Void) {
        
        guard let resource = ATCountriesAPIEnpoint(T: T.self, query: nil) else { return }
        let request = resource.request
        self.fetch(with: request, completion: completion)
    }
    
    public func search<T: Decodable>(_ value: T.Type, query: String, completion: @escaping (ATResult<T, ATAPIError>) -> Void)  {
        guard let resource = ATCountriesAPIEnpoint(T: T.self, query: query) else { return }
        let request = resource.request
        self.fetch(with: request, completion: completion)
    }
}
