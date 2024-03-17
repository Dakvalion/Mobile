//
//  WebViewController.swift
//  SecondPractice
//
//  Created by Дарья Никитина on 12.03.2024.
//

import UIKit
import SafariServices

class WebViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
    }
    
    @IBAction func safariButtonAction(_ sender: Any) {
        guard let url = URL(string: "https://www.mirea.ru") else { return }
        
        UIApplication.shared.open(url)
    }
    
    @IBAction func inAppButtonAction(_ sender: Any) {
        guard let url = URL(string: "https://www.mirea.ru") else { return }
        
        let vc = SFSafariViewController(url: url)
        present(vc, animated: true)
    }
    
    @IBAction func IntentButtonAction(_ sender: Any) {
        let textToShare = "Никитина Дарья Александровна"
        let activityViewController = UIActivityViewController(activityItems: [textToShare], applicationActivities: nil)
        activityViewController.setValue("MIREA", forKey: "subject")
        activityViewController.popoverPresentationController?.sourceView = self.view
        present(activityViewController, animated: true, completion: nil)
    }
}
