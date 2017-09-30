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
    private(set) var provider: MoyaProvider<JPMC>
    
    // MARK: - Initializers(s)
    init(provider: MoyaProvider<JPMC> = MoyaProvider<JPMC>(endpointClosure: endpointClosure,
                                                         manager: DefaultAlamofireManager.sharedManager,
                                                         plugins: [LoggerPlugin()]))
    {
        self.provider = provider
    }
    
    func search(with term: [String], completion: @escaping (Result<[Song], Moya.MoyaError>) -> Void) {
        let term = term.joined(separator: "+")
        
        let target = JPMC.search(dictionary: ["term": term])
        //requestArray(target: target) { result in
        request(target: target) { result in
            switch result {
            case let .success(json):
                print("❤️ JSON: \(json)")
                if let songsArray = json["results"] as? JSONArray {
                    var songs = [Song]()
                    for song in songsArray {
                        songs.append(Song.deserialize(from: song))
                    }
                    completion(.success(songs))
                }
            case let .failure(error):
                completion(.failure(MoyaError.underlying(error, nil)))
            }
        }
    }
    
    
}
