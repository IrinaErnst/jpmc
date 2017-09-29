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
enum Apple {
    // GET  /search?parameterkeyvalue
    case search(dictionary: JSONDictionary)
}

// MARK: - Endpoint closure.  Adds the API key to the header for the necessary targets.
let endpointClosure = { (target: Apple) -> Endpoint<Apple> in
    let defaultEndpoint = MoyaProvider<Apple>.defaultEndpointMapping(for: target)
    return defaultEndpoint.adding(newHTTPHeaderFields: ["Content-Type": "application/json"])
}

// MARK: Conformance to TargetType
extension Apple: TargetType {
    
    // MARK: Header
    var headers: [String : String]? { return [ :/*"api-key": Constants.NewYorkTimes.books*/ ]}
    
    // MARK: Base URL
    var baseURL: URL { return URL(string: Constants.Apple.baseURLString)! }
    
    // MARK: - Path
    var path: String {
        switch self {
            
        // GET List of books
        case .search(dictionary: _):
            return "/search"
        }
    }
    
    // MARK: - Method
    var method: Moya.Method {
        switch self {
        case .search(dictionary: _):
            return .get
        }
    }
    
    // MARK: - Task
    var task: Task {
        switch self {
        case .search(let dictionary):
            return .requestParameters(parameters: dictionary, encoding: URLEncoding.queryString)
        default: return .requestPlain
        }
    }
    
    // MARK: - Parameters
    var parameters: [String: Any]? {
        switch self {
            
        case .search(let dictionary):
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
