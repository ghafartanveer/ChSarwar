//
//  WebViewCollectionViewCell.swift
//  Sarwar
//
//  Created by Rizwan Ali on 14/05/2020.
//  Copyright © 2020 Rizwan Ali. All rights reserved.
//

import UIKit

class WebViewCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var viewWebView: UIWebView!
    @IBOutlet weak var lblPageTitle: UILabel!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.viewWebView.delegate = self
        self.viewWebView.isHidden = true
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
            self.activityIndicator.startAnimating()
        }
    }
    
    func configureView(data: [String: String]){
        self.lblPageTitle.text = data["title"]
        let webURL = URL(string: data["url"]!)
        self.viewWebView.loadRequest(URLRequest(url: webURL!))
    }
    
}
//MARK: - EXTENSION WEB VIEW METHOD
extension WebViewCollectionViewCell: UIWebViewDelegate{
    func webViewDidFinishLoad(_ webView: UIWebView) {
        
        self.viewWebView.isHidden = false
        self.activityIndicator.stopAnimating()
        
        print("loading Done")
    }
    
}

