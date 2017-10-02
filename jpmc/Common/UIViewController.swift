//
//  UIViewController.swift
//  jpmc
//
//  Created by Irina Ernst on 10/2/17.
//  Copyright © 2017 irinaernst. All rights reserved.
//

import Foundation
import UIKit

extension UIViewController {
    
    // Notify user about error
    func handleError(title: String, message: String) {
        let alertController = UIAlertController(title: title,
                                                message: message,
                                                preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default)
        alertController.addAction(okAction)
        self.present(alertController, animated: true)
    }
    
}
