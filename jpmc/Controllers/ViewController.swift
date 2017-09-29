//
//  ViewController.swift
//  jpmc
//
//  Created by Irina Ernst on 9/28/17.
//  Copyright © 2017 irinaernst. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    // MARK: - Properties
    private lazy var appleService: AppleService = AppleService()
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let term = ["Tom", "Waits"]
        searchInApple(with: term)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    // MARK: - Networking
    func searchInApple(with term: [String]) {
        appleService.search(with: term, completion: { result in
            switch result {
            case .success(let result):
                print("❤️❤️❤️ RESULT: \(result)")
                return
            case let .failure(error):
                print(error)
                return
            }
        })
    }


}

