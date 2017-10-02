//
//  TruckViewController.swift
//  jpmc
//
//  Created by Irina Ernst on 9/29/17.
//  Copyright © 2017 irinaernst. All rights reserved.
//

import UIKit
import WebKit

// COMMENT: Ideally I would switch from wikie to better API service. 

class LyricViewController: UIViewController {

    // MARK: - @IBOutlet(s)
    @IBOutlet weak var navigationBar: UINavigationBar!
    @IBOutlet weak var authorNameLabel: UILabel!
    @IBOutlet weak var lyricsTextField: UITextView!
    @IBOutlet weak var albumImageView: UIImageView!
    @IBOutlet weak var albumTitleLabel: UILabel!
    @IBOutlet weak var lyricsPermissionsTextField: UITextView!
    @IBOutlet weak var lyricsWikiWebButton: UIButton!
    
    
    // MARK: - Properties
    private lazy var lyricsWikiaService: LyricsWikiaService = LyricsWikiaService()
    var song: Song?
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureView()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        
        configureView()
    }
        
    // MARK: - Networking
    func getSongLyrics() {
        if let song = song {
            navigationBar.topItem?.title = song.songTitle
            authorNameLabel.text = "by " + song.artistName
            albumTitleLabel.text = song.albumName
            if let imageURL = URL(string: song.artworkUrl) {
                albumImageView.downloadImage(url: imageURL)
            }
            
            lyricsWikiaService.getLyrics(for: song, completion: { [unowned self] result in
                switch result {
                case .success(let song):
                    // TODO: do something
                    self.lyricsTextField.text = song.lyrics
                    return
                case let .failure(error):
                    self.handleError(title: error.localizedDescription, message: "Please try again!")
                    return
                }
            })
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "webSegue") {
            if let webViewController = segue.destination as? WebViewController {
                webViewController.link = song?.lyricsUrl
            }
        }
    }
    
    // MARK: - @IBAction(s)
    @IBAction func backButtonPressed(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func openWebView(_ sender: Any) {
        let webViewController = WebViewController()
        webViewController.link = song?.lyricsUrl
    }
}

// MARK: - configure view
extension LyricViewController {
    
    func configureView() {
        lyricsTextField.isUserInteractionEnabled = false
        lyricsTextField.isHidden = false
        lyricsPermissionsTextField.isUserInteractionEnabled = false
       
        getSongLyrics()
    }
}
