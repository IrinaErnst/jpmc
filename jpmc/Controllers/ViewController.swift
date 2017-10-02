//
//  ViewController.swift
//  jpmc
//
//  Created by Irina Ernst on 9/28/17.
//  Copyright © 2017 irinaernst. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    // MARK: - @IBOutlets
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var tableView: UITableView!
    
    // MARK: - Properties
    private lazy var appleService: AppleService = AppleService()
    var songs: [Song] = [Song]()
    var selectedSong: Song?
    let cellID = "truckCell"
    let emptyTextField = UITextView()
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureView()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    // MARK: - Networking
    func searchInApple(with term: String) {
        appleService.search(with: term, completion: { [unowned self] result in
            switch result {
            case .success(let songs):
                self.songs = songs
                if songs.count == 0 {
                    self.emptyTextField.isHidden = false
                    self.emptyTextField.text = "Result 0"
                } else {
                    self.emptyTextField.isHidden = true
                }
                self.tableView.reloadData()
                return
            case let .failure(error):
                print(error)
                return
            }
        })
    }
}


// MARK: - Table View Data Store
extension ViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return songs.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellID,
                                                 for: indexPath) as! SongTableViewCell
        // Change color of the selected cell
        let backgroundCellView = UIView()
        backgroundCellView.backgroundColor = UIColor.darkGray
        cell.selectedBackgroundView = backgroundCellView
        
        cell.song = songs[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70
    }
    
    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "lyricSegue") {
            if let lyricViewController = segue.destination as? LyricViewController {
                lyricViewController.song = selectedSong
            }
        }
    }
    
}

// MARK: - UITableViewDelegate
extension ViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let lyricViewController  = LyricViewController()
        selectedSong = songs[indexPath.row]
        lyricViewController.song = selectedSong
        performSegue(withIdentifier: "lyricSegue", sender: self)
    }
    
}

// MARK: - UISearchBarDelegate
extension ViewController: UISearchBarDelegate {
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        if let term = searchBar.text?.replacingOccurrences(of: " ", with: "+") {
            searchInApple(with: term)
        }
    }
    
}


// MARK: - Table View Configure
extension ViewController {
    
    func configureView(){
        configureTableView()
        configureSearchBar()
        configureEmptyView()
    }
    
    func configureTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.backgroundColor = UIColor.black
        tableView.tableFooterView = UIView(frame: .zero)
    }
    
    func configureSearchBar() {
        searchBar.delegate = self
        searchBar.placeholder = "Music search (Ex, Tom Waits)"
    }
    
    func configureEmptyView() {
        emptyTextField.isUserInteractionEnabled = false
        emptyTextField.text = "Enter artist's full name, name of the song, or name of the album in the " +
        "search bar and press the return key"
        emptyTextField.textColor = UIColor.lightGray
        emptyTextField.backgroundColor = UIColor.black
        emptyTextField.textAlignment = .center
        emptyTextField.frame = CGRect(x: 20,
                                      y: 150,
                                      width: view.frame.width-40,
                                      height: view.frame.height-300)
        emptyTextField.font = UIFont.boldSystemFont(ofSize: 14)
        
        view.addSubview(emptyTextField)
    }
    
}
