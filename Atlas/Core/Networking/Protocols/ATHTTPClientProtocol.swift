//
//  HTTPClient.swift
//  Atlas
//
//  Created by Kostiantyn Madiar on 12/25/18.
//  Copyright © 2018 Kostiantyn Madiar. All rights reserved.
//

import Foundation

protocol ATHTTPClientProtocol {
    var session: URLSession { get }
    func fetch(with request: URLRequest, completion: @escaping (ATResult<Data, ATAPIError>) -> Void)
    func fetchAndDecodeJSON<T: Decodable>(with request: URLRequest, decodingType: T.Type, completionHandler completion: @escaping (ATResult<T, ATAPIError>) -> Void)
}

extension ATHTTPClientProtocol {
    
    typealias JSONTaskCompletionHandler = (Decodable?, ATAPIError?) -> Void
    typealias DataTaskCompletionHandler = (Data?, ATAPIError?) -> Void

    func fetchAndDecodeJSON<T: Decodable>(with request: URLRequest, decodingType: T.Type, completionHandler completion: @escaping (ATResult<T, ATAPIError>) -> Void) {
        
        fetch(with: request) { (result) in
            switch result {
            case .success(let data):
                do {
                    let decoder = JSONDecoder()
                    decoder.keyDecodingStrategy = .convertFromSnakeCase
                    let genericModel = try decoder.decode(decodingType, from: data)
                    completion(.success(genericModel))
                } catch let error {
                    completion(.failure(.jsonConversionFailure(description: error.localizedDescription)))
                }
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    func fetch(with request: URLRequest, completion: @escaping (ATResult<Data, ATAPIError>) -> Void) {
        let task = networkTask(with: request) { (data , error) in
            guard let data = data else {
                if let error = error {
                    completion(ATResult.failure(error))
                } else {
                    completion(ATResult.failure(.invalidData))
                }
                return
            }
            completion(.success(data))
        }
        task.resume()
    }
    
    func networkTask(with request: URLRequest, completionHandler completion: @escaping DataTaskCompletionHandler) -> URLSessionDataTask {
        let task = session.dataTask(with: request) { data, response, error in
            guard let httpResponse = response as? HTTPURLResponse else {
                completion(nil, .requestFailed(description: error.debugDescription))
                return
            }
            if httpResponse.statusCode == 200 {
                if let data = data {
                    completion(data, nil)
                } else {
                    completion(nil, .invalidData)
                }
            } else {
                completion(nil, .responseUnsuccessful(description: "status code = \(httpResponse.statusCode)"))
            }
        }
        return task
    }
}

