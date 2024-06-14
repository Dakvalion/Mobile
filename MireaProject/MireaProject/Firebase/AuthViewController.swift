//
//  FBAuthViewController.swift
//  Lesson7
//
//  Created by Дарья Никитина on 18.05.2024.
//

import UIKit
import FirebaseAuth

class FBAuthViewController: UIViewController {
    
    // MARK: - Outlets
    
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        Auth.auth().addStateDidChangeListener { [weak self] (_, user) in
            if user != nil {
                self?.showMainScreen()
            } else {
                self?.emailTextField.text = nil
                self?.passwordTextField.text = nil
            }
        }
    }
    
    // MARK: - Actions
    
    @IBAction func loginButtonTapped(_ sender: UIButton) {
        guard let email = emailTextField.text, !email.isEmpty,
              let password = passwordTextField.text, !password.isEmpty else {
            showToast(title: "Заполните все поля формы", message: "")
            return
        }
        
        Auth.auth().signIn(withEmail: email, password: password) { [weak self] (_, error) in
            if let error = error {
                self?.showToast(title: "Ошибка!", message: error.localizedDescription)
            }
        }
    }
    
    @IBAction func createAccountButtonTapped(_ sender: UIButton) {
        guard let email = emailTextField.text, !email.isEmpty,
              let password = passwordTextField.text, !password.isEmpty else {
            showToast(title: "Заполните все поля формы", message: "")
            return
        }
        
        Auth.auth().createUser(withEmail: email, password: password) { [weak self] (result, error) in
            if let error = error {
                self?.showToast(title: "Ошибка!", message: error.localizedDescription)
            }
        }
    }
    
    func showMainScreen() {
        let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
        guard let mainPageViewController = storyboard.instantiateViewController(
            withIdentifier: "mainPage"
        ) as? MainPageViewController else { return }
        mainPageViewController.modalPresentationStyle = .fullScreen
        present(mainPageViewController, animated: true)
    }
    
    func showToast(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        present(alert, animated: true, completion: nil)
    }
}
