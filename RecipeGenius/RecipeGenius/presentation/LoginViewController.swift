//
//  ViewController.swift
//  RecipeGenius
//
//  Created by Daria Nikitina on 28.09.2024.
//

import UIKit
import domain
import data

class LoginViewController: UIViewController {
    private var vm: LoginViewModel
    
    @IBOutlet weak var loginTextField: UITextField!
    
    @IBOutlet weak var passwordTextField: UITextField!
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        vm = ViewModelFactory().create(modelClass: LoginViewModel.self)
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }
    
    required init?(coder: NSCoder) {
        vm = ViewModelFactory().create(modelClass: LoginViewModel.self)
        super.init(coder: coder)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        NotificationCenter.default.addObserver(self, selector: #selector(authStateChanged(_:)), name: Notification.Name("AuthStateChanged"), object: nil)
    }
    
    @objc func authStateChanged(_ notification: Notification) {
        if let success = notification.object as? Bool {
            if success {
                print("Успешная аутентификация - \(vm.user?.uid ?? "")")
            } else {
                print("Ошибка аутентификации - \(vm.error?.localizedDescription ?? "")")
            }
        }
    }
    
    @IBAction func signIn(_ sender: Any) {
        vm.signIn(loginInput: loginTextField.text, passwordInput: passwordTextField.text)
    }
    
    @IBAction func createAccount(_ sender: Any) {
        vm.createAccount(loginInput: loginTextField.text, passwordInput: passwordTextField.text)
    }
    
    @IBAction func skipAuth(_ sender: Any) {
        let result = vm.skipAuth()
        if result {
            print("Мы успешно вошли как гость")
        }
    }
}
