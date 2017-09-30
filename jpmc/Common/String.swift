//
//  String.swift
//  jpmc
//
//  Created by Irina Ernst on 9/29/17.
//  Copyright © 2017 irinaernst. All rights reserved.
//

import Foundation

extension String {
    var urlEscaped: String {
        return addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)!
    }
}

