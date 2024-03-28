//
//  ViewController.swift
//  Lesson3
//
//  Created by Дарья Никитина on 23.03.2024.
//

import UIKit

/// Задание 1.5
class ViewController: UIViewController {
    
    var formattedTime: String {
        let dateInMillis = Date().timeIntervalSince1970
        let format = "yyyy-MM-dd HH:mm:ss"
        let formatter = DateFormatter()
        formatter.dateFormat = format
        return formatter.string(from: Date(timeIntervalSince1970: TimeInterval(dateInMillis)))
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard segue.identifier == "segue",
              let destination = segue.destination as? SecondViewController
        else { return }
        
        destination.squaredPositionNumber = 17 * 17
        destination.formattedTime = formattedTime
    }
}
