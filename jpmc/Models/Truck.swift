//
//  Truck.swift
//  jpmc
//
//  Created by Irina Ernst on 9/28/17.
//  Copyright © 2017 irinaernst. All rights reserved.
//

import UIKit

class Truck: NSObject {

    var trackName: String!
    var artistName: String!
    var albumName: String?
    var albumImageUrl: String?
    
    // MARK: - Deserializer
    static func deserialize(from json: JSONDictionary) -> Truck {
        let trackName = json["trackName"]
        let artistName = json["artistName"]
        let albumName = json["albumName"]
        let albumImageUrl = json["artworkUrl100"]
        
        return Book_details(value: ["trackName": trackName,
                                    "artistName": artistName,
                                    "albumName": albumName,
                                    "contributor": albumImageUrl
            ])
    }
    
}
