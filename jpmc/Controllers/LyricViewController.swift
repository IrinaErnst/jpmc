//
//  TruckViewController.swift
//  jpmc
//
//  Created by Irina Ernst on 9/29/17.
//  Copyright © 2017 irinaernst. All rights reserved.
//

import UIKit

class LyricViewController: UIViewController {

    // MARK: - Properties
    private lazy var appleService: AppleService = AppleService()
    var truck: Truck?

    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        appleService.search(with: term, completion: { [unowned self] result in
//            switch result {
//            case .success(let trucks):
//                self.trucks = trucks
//                self.tableView.reloadData()
//                return
//            case let .failure(error):
//                print(error)
//                return
//            }
//        })
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

}
