//
//  TruckTableViewCell.swift
//  jpmc
//
//  Created by Irina Ernst on 9/29/17.
//  Copyright © 2017 irinaernst. All rights reserved.
//

import UIKit

class TruckTableViewCell: UITableViewCell {

    // MARK: - IBOutlets
    @IBOutlet weak var artworkImageView: UIImageView!
    @IBOutlet weak var truckNameLabel: UILabel!
    @IBOutlet weak var artistNameLabel: UILabel!
    @IBOutlet weak var albumNameLabel: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    var truck: Truck? {
        
        didSet{
            
            if let artworkUrl = truck?.artworkUrl {
                if let imageURL = URL(string: artworkUrl) {
                    artworkImageView.contentMode = .scaleAspectFit
                    artworkImageView.downloadImage(url: imageURL)
                }
            } 
            
            if let truckName = truck?.trackName {
                truckNameLabel.text = truckName
            }
            
            if let artistName = truck?.artistName {
                artistNameLabel.text = artistName
            }
            
            if let albumName = truck?.albumName {
                albumNameLabel.text = albumName
            }
            
        }
    }
    
    
}
