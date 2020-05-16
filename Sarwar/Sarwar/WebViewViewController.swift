//
//  ViewController.swift
//  Sarwar
//
//  Created by Rizwan Ali on 14/05/2020.
//  Copyright © 2020 Rizwan Ali. All rights reserved.
//

import UIKit
import Foundation
import SystemConfiguration

struct ScreenSize
{
    static let SCREEN_WIDTH = UIScreen.main.bounds.size.width
    static let SCREEN_HEIGHT = UIScreen.main.bounds.size.height
    static let SCREEN_MAX_LENGTH = max(ScreenSize.SCREEN_WIDTH, ScreenSize.SCREEN_HEIGHT)
    static let SCREEN_MIN_LENGTH = min(ScreenSize.SCREEN_WIDTH, ScreenSize.SCREEN_HEIGHT)
}
    
class WebViewViewController: UIViewController {
    
    @IBOutlet weak var viewCollection: UICollectionView!
   
    let IS_IPHONE_X_All = (UIDevice.current.userInterfaceIdiom == .phone && (ScreenSize.SCREEN_MAX_LENGTH == 812 || ScreenSize.SCREEN_MAX_LENGTH == 896))
    var URLCount = 0
    let arrayURL = ["https://www.facebook.com/ChMohammadSarwar/?ref=br_rs","https://www.facebook.com/SarwarFoundation/","https://twitter.com/ChMSarwar","https://twitter.com/TeamSarwar"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        checkInternetConnection()
    }
   //MARK: - FUNCTION
    func checkInternetConnection(){
        if isConnectedToNetwork(){
            self.URLCount = arrayURL.count
            self.viewCollection.reloadData()
            
        }else{
            self.showAlertPopup(title: "Sarwar", message: "Unable to connect your network")
        }
    }
    func showAlertPopup(title: String, message: String){
        let alert = UIAlertController.init(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction.init(title: "Try again", style: UIAlertAction.Style.default, handler: { (UIAlertAction) in
            alert.dismiss(animated: true, completion: nil)
            self.checkInternetConnection()
        }))
        self.present(alert, animated: true, completion: nil)
    }
    
    func isConnectedToNetwork() -> Bool {
        
        var zeroAddress = sockaddr_in(sin_len: 0, sin_family: 0, sin_port: 0, sin_addr: in_addr(s_addr: 0), sin_zero: (0, 0, 0, 0, 0, 0, 0, 0))
        zeroAddress.sin_len = UInt8(MemoryLayout.size(ofValue: zeroAddress))
        zeroAddress.sin_family = sa_family_t(AF_INET)
        
        let defaultRouteReachability = withUnsafePointer(to: &zeroAddress) {
            $0.withMemoryRebound(to: sockaddr.self, capacity: 1) {zeroSockAddress in
                SCNetworkReachabilityCreateWithAddress(nil, zeroSockAddress)
            }
        }
        
        var flags: SCNetworkReachabilityFlags = SCNetworkReachabilityFlags.connectionRequired
        if SCNetworkReachabilityGetFlags(defaultRouteReachability!, &flags) == false {
            return false
        }
        
        let isReachable = (flags.rawValue & UInt32(kSCNetworkFlagsReachable)) != 0
        let needsConnection = (flags.rawValue & UInt32(kSCNetworkFlagsConnectionRequired)) != 0
        
        return (isReachable && !needsConnection) ? true : false
    }
    
    
}
//MARK: - EXTENSION COLLECTION VIEW METHOD
extension WebViewViewController: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.URLCount
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let webCell = collectionView.dequeueReusableCell(withReuseIdentifier: "webViewCell", for: indexPath) as! WebViewCollectionViewCell
        webCell.configureView(data: self.arrayURL[indexPath.row])
        return webCell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let height = view.frame.size.height
        let width = view.frame.size.width
        
        if IS_IPHONE_X_All{
            return CGSize(width: width, height: height-40)
        }else{
            
            return CGSize(width: width, height: height-20)
        }
        
    }
    
}

