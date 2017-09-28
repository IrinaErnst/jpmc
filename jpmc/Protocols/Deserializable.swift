//
//  Deserializable.swift
//  jpmc
//
//  Created by Irina Ernst on 9/28/17.
//  Copyright © 2017 irinaernst. All rights reserved.
//

import Foundation

protocol Deserializable {
    static func deserialize(from json: JSONDictionary) -> Self
    static func deserialize(from json: JSONArray) -> [Self]
}

extension Deserializable {
    static func deserialize(from json: JSONArray) -> [Self] {
        var list = [Self]()
        for jsonDictionary in json {
            let new = deserialize(from: jsonDictionary)
            list.append(new)
        }
        return list
    }
    
    public func decode<T>(_ dictionary: JSONDictionary, key: String) throws -> T {
        guard let value = dictionary[key] else {
            throw JSONDeserializationError.missingAttribute(key: key)
        }
        
        guard let attribute = value as? T else {
            throw JSONDeserializationError.invalidAttributeType(key: key,
                                                                expectedType: T.self,
                                                                receivedValue: value)
        }
        
        return attribute
    }
}
