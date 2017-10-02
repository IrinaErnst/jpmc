//
//  Truck.swift
//  jpmc
//
//  Created by Irina Ernst on 9/28/17.
//  Copyright © 2017 irinaernst. All rights reserved.
//

import UIKit

final class Song: NSObject, Deserializable {

    var songTitle: String!
    var artistName: String!
    var albumName: String!
    var artworkUrl: String!
    var lyricsUrl: String?
    var lyrics: String?
    
    // Initialiser(s)
    init(songTitle: String, artistName: String, albumName: String, artworkUrl: String) {
        super.init()
        
        self.songTitle = songTitle
        self.artistName = artistName
        self.albumName = albumName
        self.artworkUrl = artworkUrl
    }
    
    // MARK: - Deserializer
    static func deserialize(from json: JSONDictionary) -> Song {
        let songTitle = (json["trackName"] as? String) ?? "N/A"
        let artistName = (json["artistName"] as? String) ?? "N/A"
        let albumName = (json["collectionName"] as? String) ?? "Unknown"
        let artworkUrl = (json["artworkUrl100"] as? String) ?? ""
        
        return Song.init(songTitle: songTitle,
                          artistName: artistName,
                          albumName: albumName,
                          artworkUrl: artworkUrl)
    }
    
}
