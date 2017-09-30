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
    var trucks: [Truck] = [Truck]()
    var selectedTruck: Truck?
    let cellID = "truckCell"
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureView()
        
        let term = ["Josh", "Ritter"]
        searchInApple(with: term)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    // MARK: - Networking
    func searchInApple(with term: [String]) {
        appleService.search(with: term, completion: { [unowned self] result in
            switch result {
            case .success(let trucks):
                self.trucks = trucks
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
        return trucks.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellID,
                                                 for: indexPath) as! TruckTableViewCell
        // Change color of the selected cell
        let backgroundCellView = UIView()
        backgroundCellView.backgroundColor = UIColor.darkGray
        cell.selectedBackgroundView = backgroundCellView
        
        cell.truck = trucks[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70
    }
    
    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "lyricSegue") {
            if let lyricViewController = segue.destination as? LyricViewController {
                lyricViewController.truck = selectedTruck
            }
        }
    }
    
}

// MARK: - UITableViewDelegate
extension ViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let lyricViewController  = LyricViewController()
        selectedTruck = trucks[indexPath.row]
        lyricViewController.truck = selectedTruck
        performSegue(withIdentifier: "lyricSegue", sender: self)
    }
    
}


// MARK: - Table View Configure
extension ViewController {
    
    func configureView(){
        configureTableView()
        searchInApple(with: ["Josh", "Ritter"])
    }
    
    func configureTableView() {
        tableView.backgroundColor = UIColor.black
        
        tableView.delegate = self
        tableView.dataSource = self
        
        tableView.tableFooterView = UIView(frame: .zero)
    }
}
