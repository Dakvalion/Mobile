//
//  WorkerViewController.swift
//  Lesson4
//
//  Created by Дарья Никитина on 14.04.2024.
//

import UIKit
import BackgroundTasks

final class WorkerViewController: UIViewController {
    
    @IBOutlet weak var label: UILabel!
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        let counter = UserDefaults.standard.integer(forKey: "notifyUserCounter")
        label.text = "Количество отправленных пушей: \(counter)"
    }
}
