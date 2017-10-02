//
//  WebViewController.swift
//  jpmc
//
//  Created by Irina Ernst on 10/1/17.
//  Copyright © 2017 irinaernst. All rights reserved.
//

import UIKit
import WebKit

class WebViewController: UIViewController {

    // MARK: - @IBOutlet(s)
    @IBOutlet weak var webView: UIWebView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    // MARK: - Propertie(s)
    var link: String?
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()

        activityIndicator?.color = UIColor.darkGray
        activityIndicator?.startAnimating()
        activityIndicator.hidesWhenStopped = true
        
        //webView.navigationDelegate = self
        
        if let url = URL(string: link ?? "http://lyrics.wikia.com/wiki/Lyrics_Wiki") {
            webView.loadRequest(URLRequest(url: url))
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - @IBAction(s)
    @IBAction func backButtonPressed(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
}


// MARK: - WKNavigationDelegate
extension WebViewController: WKNavigationDelegate {
    
    func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) {
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
    }
    
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        UIApplication.shared.isNetworkActivityIndicatorVisible = false
        activityIndicator?.stopAnimating()
    }
}
