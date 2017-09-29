//
//  Truck.swift
//  jpmc
//
//  Created by Irina Ernst on 9/28/17.
//  Copyright © 2017 irinaernst. All rights reserved.
//

import UIKit

final class Truck: NSObject, Deserializable {

    var trackName: String!
    var artistName: String!
    var albumName: String?
    var artworkUrl: String?
    
    // Initialiser(s)
    init(trackName: String, artistName: String, albumName: String, artworkUrl: String) {
        super.init()
        
        self.trackName = trackName
        self.artistName = artistName
        self.albumName = albumName
        self.artworkUrl = artworkUrl
    }
    
    // MARK: - Deserializer
    static func deserialize(from json: JSONDictionary) -> Truck {
        let trackName = json["trackName"] as! String
        let artistName = json["artistName"] as! String
        let albumName = json["collectionName"] as! String
        let artworkUrl = json["artworkUrl100"] as! String
        
        return Truck.init(trackName: trackName,
                          artistName: artistName,
                          albumName: albumName,
                          artworkUrl: artworkUrl)
    }
    
}
