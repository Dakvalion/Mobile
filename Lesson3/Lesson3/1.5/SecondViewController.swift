//
//  SecondViewController.swift
//  Lesson3
//
//  Created by Дарья Никитина on 27.03.2024.
//

import UIKit

/// Задание 1.5
class SecondViewController: UIViewController {
    
    @IBOutlet weak var textView: UITextView!
    var squaredPositionNumber: Int!
    var formattedTime: String!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        textView.text = "КВАДРАТ ЗНАЧЕНИЯ МОЕГО НОМЕРА ПО СПИСКУ В ГРУППЕ СОСТАВЛЯЕТ \(squaredPositionNumber!), а текущее время \(formattedTime!)"
    }
}
