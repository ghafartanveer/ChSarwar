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
    
    func configureView(data: String){
        let webURL = URL(string: data)
        self.viewWebView.loadRequest(URLRequest(url: webURL!))
    }
    
}
