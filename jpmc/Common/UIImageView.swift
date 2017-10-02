//
//  UIImageView.swift
//  jpmc
//
//  Created by Irina Ernst on 9/29/17.
//  Copyright © 2017 irinaernst. All rights reserved.
//

import UIKit

extension UIImageView {
    func getDataFromUrl(url: URL, completion: @escaping (Data?, URLResponse?, Error?) -> ()) {
        URLSession.shared.dataTask(with: url) { data, response, error in
            completion(data, response, error)
            }.resume()
    }
    
    func downloadImage(url: URL) {
        getDataFromUrl(url: url) { data, response, error in
            guard let data = data, error == nil else { return }
            // print(response?.suggestedFilename ?? url.lastPathComponent)
            // Download Finished
            DispatchQueue.main.async() {
                self.image = UIImage(data: data)
            }
        }
    }
}
