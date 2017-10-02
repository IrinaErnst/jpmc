//
//  LyricaWikieService.swift
//  jpmc
//
//  Created by Irina Ernst on 9/30/17.
//  Copyright © 2017 irinaernst. All rights reserved.
//

import Foundation
import Moya
import Result
import JASON


// http://lyrics.wikia.com/api.php?func=getSong&artist=Tom+Waits&song=new+coat+of+paint&fmt=json
struct LyricsWikiaService: NetworkServiceType {

    // MARK: - Properties
    private(set) var provider: MoyaProvider<JPMC>

    // MARK: - Initializers(s)
    init(provider: MoyaProvider<JPMC> = MoyaProvider<JPMC>(endpointClosure: endpointClosure,
                                                           manager: DefaultAlamofireManager.sharedManager,
                                                           plugins: [LoggerPlugin()]))
    {
        self.provider = provider
    }

    func getLyrics(for song: Song, completion: @escaping (Result<Song, Moya.MoyaError>) -> Void) {
        let artist = song.artistName.replacingOccurrences(of: " ", with: "+")
        let songName = song.songTitle.replacingOccurrences(of: " ", with: "+")
        //let dictionary = ["func": "getSong", "artist": artist, "song": song, "fmt": "json", "action": "lyrics"]
        let dictionary = ["func": "getSong", "artist": artist, "song": songName, "fmt": "realjson", "action": "lyrics", "useSOAP": false] as [String : Any]

        let target = JPMC.getSong(dictionary: dictionary)
        request(target: target) { result in
            switch result {
            case let .success(json):
                
                song.lyrics = json["lyrics"] as? String
                song.lyricsUrl = json["url"] as? String
                
                completion(.success(song))
            case let .failure(error):
                completion(.failure(MoyaError.underlying(error, nil)))
            }
        }
    }
    
    
}

