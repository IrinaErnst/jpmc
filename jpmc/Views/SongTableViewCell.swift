//
//  TruckTableViewCell.swift
//  jpmc
//
//  Created by Irina Ernst on 9/29/17.
//  Copyright © 2017 irinaernst. All rights reserved.
//

import UIKit

class SongTableViewCell: UITableViewCell {

    // MARK: - IBOutlets
    @IBOutlet weak var artworkImageView: UIImageView!
    @IBOutlet weak var songTitleLabel: UILabel!
    @IBOutlet weak var artistNameLabel: UILabel!
    @IBOutlet weak var albumNameLabel: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    var song: Song? {
        
        didSet{
            
            if let artworkUrl = song?.artworkUrl {
                if let imageURL = URL(string: artworkUrl) {
                    artworkImageView.contentMode = .scaleAspectFit
                    artworkImageView.downloadImage(url: imageURL)
                }
            } 
            
            if let songTitle = song?.songTitle {
                songTitleLabel.text = songTitle
            }
            
            if let artistName = song?.artistName {
                artistNameLabel.text = artistName
            }
            
            if let albumName = song?.albumName {
                albumNameLabel.text = albumName
            }
            
        }
    }
    
    
}
