//
//  AppleService.swift
//  jpmc
//
//  Created by Irina Ernst on 9/28/17.
//  Copyright © 2017 irinaernst. All rights reserved.
//

import Foundation

import Moya
import Result
import JASON

struct AppleService: NetworkServiceType {
    
    // MARK: - Properties
    private(set) var provider: MoyaProvider<Apple>
    
    // MARK: - Initializers(s)
    init(provider: MoyaProvider<Apple> = MoyaProvider<Apple>(endpointClosure: endpointClosure,
                                                         manager: DefaultAlamofireManager.sharedManager,
                                                         plugins: [LoggerPlugin()]))
    {
        self.provider = provider
    }
    
    func search(for target: Apple, completion: @escaping (Result<JSONDictionary, Moya.MoyaError>) -> Void) {
        
        request(target: target) { result in
            switch result {
            case let .success(json):
                
                print("❤️ JSON: \(json)")
                completion(.success(json))
            case let .failure(error):
                completion(.failure(MoyaError.underlying(error, nil)))
            }
        }
    }
    
    
}
