//
//  TruckViewController.swift
//  jpmc
//
//  Created by Irina Ernst on 9/29/17.
//  Copyright © 2017 irinaernst. All rights reserved.
//

import UIKit

class LyricViewController: UIViewController {

    // MARK: - @IBOutlet(s)
    @IBOutlet weak var navigationBar: UINavigationBar!
    @IBOutlet weak var authorNameLabel: UILabel!
    @IBOutlet weak var lyricsTextField: UITextView!
    
    // MARK: - Properties
    private lazy var lyricsWikiaService: LyricsWikiaService = LyricsWikiaService()
    var song: Song?
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        getSongLyrics()
    }
        
    // MARK: - Networking
    func getSongLyrics() {
        if let song = song {
            navigationBar.topItem?.title = song.songTitle
            authorNameLabel.text = "by " + song.artistName
            
            lyricsWikiaService.getSongLyric(with: song, completion: { [unowned self] result in
                switch result {
                case .success(let lyrics):
                    // TODO: do something
                    self.lyricsTextField.text = lyrics
                    return
                case let .failure(error):
                    print(error)
                    return
                }
            })
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    // MARK: - @IBAction(s)
    @IBAction func backButtonPressed(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
}
