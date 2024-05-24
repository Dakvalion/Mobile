//
//  MainPageViewController.swift
//  Lesson7
//
//  Created by Дарья Никитина on 18.05.2024.
//

import UIKit
import FirebaseAuth

class MainPageViewController: UIViewController {
    
    @IBAction func logoutButtonTapped(_ sender: Any) {
        do {
            try Auth.auth().signOut()
            dismiss(animated: true)
        } catch {
            print("Ошибка при выходе: \(error.localizedDescription)")
        }
    }
}
