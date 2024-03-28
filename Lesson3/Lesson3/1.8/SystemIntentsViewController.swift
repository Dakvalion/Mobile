//
//  SystemIntentsViewController.swift
//  Lesson3
//
//  Created by Егор Бадмаев on 27.03.2024.
//

import UIKit

class SystemIntentsViewController: UIViewController {
    @IBAction func callPhoneButtonAction(_ sender: Any) {
        guard let url = URL(string: "tel://89811112233"), UIApplication.shared.canOpenURL(url)
        else { return }
        
        UIApplication.shared.open(url)
    }
    
    @IBAction func openBrowserButtonAction(_ sender: Any) {
        guard let url = URL(string: "http://developer.apple.com"),
              UIApplication.shared.canOpenURL(url)
        else { return }
        
        UIApplication.shared.open(url)
    }
    
    @IBAction func openMapButtonAction(_ sender: Any) {
        guard let url = URL(string: "maps://?q=\(55.749479),\(37.613944)"),
              UIApplication.shared.canOpenURL(url)
        else { return }
        
        UIApplication.shared.open(url)
    }
}
