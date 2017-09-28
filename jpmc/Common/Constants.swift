//
//  Constants.swift
//  jpmc
//
//  Created by Irina Ernst on 9/28/17.
//  Copyright © 2017 irinaernst. All rights reserved.
//
// App constants
struct Constants {
    
    // MARK: - private initializer.  Safeguard against developers attempting to instantiate.
    private init() {}
    
    struct Apple {
        private init() {}
        static let baseURLString = "https://itunes.apple.com/"
    }
    
    struct LyricWikia {
        private init() {}
        static let baseURLString = "http://lyrics.wikia.com/"
    }
}

