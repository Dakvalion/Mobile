//
//  ProfileViewController.swift
//  Lesson6
//
//  Created by Дарья Никитина on 13.05.2024.
//

import UIKit

class ProfileViewController: UIViewController {
    
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var ageTextField: UITextField!
    @IBOutlet weak var notificationsSwitch: UISwitch!
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        nameTextField.text = UserDefaults.standard.string(forKey: "name")
        ageTextField.text = UserDefaults.standard.string(forKey: "age")
        notificationsSwitch.isOn = UserDefaults.standard.bool(forKey: "notifications")
    }
    
    @IBAction func nameTextFieldChanged(_ sender: UITextField) {
        guard let name = nameTextField.text,
              !name.isEmpty else { return }
        
        UserDefaults.standard.set(name, forKey: "name")
    }
    
    @IBAction func ageTextFieldChanged(_ sender: UITextField) {
        guard let age = ageTextField.text,
              !age.isEmpty else { return }
        
        UserDefaults.standard.set(age, forKey: "age")
    }
    
    @IBAction func notificationDidTapped(_ sender: UISwitch) {
        UserDefaults.standard.set(sender.isOn, forKey: "notifications")
    }
}
