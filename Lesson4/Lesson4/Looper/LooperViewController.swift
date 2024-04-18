//
//  LooperViewController.swift
//  Lesson4
//
//  Created by Дарья Никитина on 14.04.2024.
//

import UIKit

class LooperViewController: UIViewController {
    let looper = MyLooper { result in
        print("Task execute. This is result: " + result)
    }
    @IBOutlet weak var mireaTextView: UITextView!
    @IBOutlet weak var ageTextField: UITextField!
    @IBOutlet weak var gradeTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        mireaTextView.text = "Мой номер по списку №17"
    }
    
    @IBAction func onClick(_ sender: Any) {
        guard let age = Int(ageTextField.text ?? ""),
              let grade = gradeTextField.text,
              !grade.isEmpty else { return }
        looper.mHandler = { (age, grade) }
        looper.start()
    }
}
