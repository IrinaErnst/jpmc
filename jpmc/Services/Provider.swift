//
//  Provider.swift
//  jpmc
//
//  Created by Irina Ernst on 9/28/17.
//  Copyright © 2017 irinaernst. All rights reserved.
//

import Foundation
import Moya


func JSONResponseDataFormatter(_ data: Data) -> Data {
    do {
        let dataAsJSON = try JSONSerialization.jsonObject(with: data)
        let prettyData =  try JSONSerialization.data(withJSONObject: dataAsJSON, options: .prettyPrinted)
        return prettyData
    } catch {
        return data // fallback to original data if it can't be serialized.
    }
}


// MARK: - Target
enum JPMC {
    //Apple GET  /search?parameterkeyvalue
    case search(dictionary: JSONDictionary)
    
    //LyricWikia GET  /api.php?func=getSong&artist=Tom+Waits&song=new+coat+of+paint&fmt=json
    case getSong(dictionary: JSONDictionary)
}

// MARK: - Endpoint closure.  Adds the API key to the header for the necessary targets.
let endpointClosure = { (target: JPMC ) -> Endpoint<JPMC> in
    let defaultEndpoint = MoyaProvider<JPMC>.defaultEndpointMapping(for: target)
    return defaultEndpoint.adding(newHTTPHeaderFields: ["Content-Type": "application/json"])
}

// MARK: Conformance to TargetType
extension JPMC: TargetType {
    
    // MARK: Header
    var headers: [String : String]? { return [ :/*"api-key": Constants.NewYorkTimes.books*/ ]}
    
    // MARK: Base URL
    var baseURL: URL {
        switch self {
        case .search(dictionary: _):
            return URL(string: Constants.Apple.baseURLString)!
        case .getSong(dictionary: _):
            return URL(string: Constants.LyricWikia.baseURLString)!
        }
    }
    
    // MARK: - Path
    var path: String {
        switch self {

        case .search(dictionary: _):
            return "/search"
        case .getSong(dictionary: _):
            return "/api.php"
        }
    }
    
    // MARK: - Method
    var method: Moya.Method {
        switch self {
        case .search(dictionary: _),
             .getSong(dictionary: _):
            return .get
        }
    }
    
    // MARK: - Task
    var task: Task {
        switch self {
        case .search(let dictionary),
             .getSong(let dictionary):
            return .requestParameters(parameters: dictionary, encoding: URLEncoding.default)
        // default: return .requestPlain
        }
    }
    
    // MARK: - Parameters
    var parameters: [String: Any]? {
        switch self {
            
        case .search(let dictionary):
            return dictionary
        case .getSong(let dictionary):
            return dictionary
        }
    }
    
    var parameterEncoding: ParameterEncoding {
        return JSONEncoding.default
    }
    
    // MARK: - Sample Data.
    // TODO: - Stub network responses
    var sampleData: Data {
        return "".data(using: .utf8)!
    }
}
