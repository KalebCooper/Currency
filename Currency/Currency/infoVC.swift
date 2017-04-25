//
//  infoVC.swift
//  CurrencyConversion
//
//  Created by Kaleb Cooper on 4/24/17.
//  Copyright © 2017 Kaleb Cooper. All rights reserved.
//

import Foundation
import UIKit

class infoVC: UIViewController{
    
    
    //MARK: Outlets
    @IBOutlet weak var rateAppOutlet: UIButton!
    @IBOutlet weak var howToOutlet: UILabel!
    @IBOutlet weak var para1Outlet: UILabel!
    @IBOutlet weak var para2Outlet: UILabel!
    @IBOutlet weak var thankYouOutlet: UILabel!
    
    
    //MARK: Actions
    @IBAction func rateAppAction(_ sender: Any) {
        
        let url = URL(string: "https://www.apple.com")!
            
            //itms-apps://itunes.apple.com/us/app/apple-store/YOUR_APP_ID?mt=8)!
            
        if #available(iOS 10.0, *) {
            UIApplication.shared.open(url, options: [:], completionHandler: nil)
        } else {
            UIApplication.shared.openURL(url)
        }
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let swiftColor = UIColor(red: 102/255, green: 255/255, blue: 102/255, alpha: 1)
        
        rateAppOutlet.backgroundColor = .clear
        rateAppOutlet.layer.cornerRadius = 3
        rateAppOutlet.layer.borderWidth = 1
        rateAppOutlet.layer.borderColor = swiftColor.cgColor
        
//        howToOutlet.minimumScaleFactor = 0.5
//        howToOutlet.numberOfLines = 1
//        howToOutlet.adjustsFontSizeToFitWidth = true
//        
//        para1Outlet.minimumScaleFactor = 0.5
//        para1Outlet.numberOfLines = 1
//        para1Outlet.adjustsFontSizeToFitWidth = true
//        
//        para2Outlet.minimumScaleFactor = 0.5
//        para2Outlet.numberOfLines = 1
//        para2Outlet.adjustsFontSizeToFitWidth = true
//        
        thankYouOutlet.minimumScaleFactor = 0.5
        thankYouOutlet.numberOfLines = 1
        thankYouOutlet.adjustsFontSizeToFitWidth = true
        
        rateAppOutlet.titleLabel!.minimumScaleFactor = 0.5
        rateAppOutlet.titleLabel!.numberOfLines = 1
        rateAppOutlet.titleLabel!.adjustsFontSizeToFitWidth = true
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}

