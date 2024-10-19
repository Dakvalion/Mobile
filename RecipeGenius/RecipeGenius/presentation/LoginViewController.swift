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
    private let authRepository: AuthRepository = AuthRepositoryImpl(firebaseService: FirebaseServiceImpl(), sharedPreferences: SharedPreferencesServiceImpl())
    
    @IBOutlet weak var loginTextField: UITextField!
    
    @IBOutlet weak var passwordTextField: UITextField!
    
    @IBAction func signIn(_ sender: Any) {
        guard let email = loginTextField.text, !email.isEmpty,
              let password = passwordTextField.text, !password.isEmpty else {
            return
        }
        SignInUseCase(authRepository: authRepository).execute(email: email, password: password) { result in
            switch result {
            case .success(let user):
                print(user.uid)
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    @IBAction func createAccount(_ sender: Any) {
        guard let email = loginTextField.text, !email.isEmpty,
              let password = passwordTextField.text, !password.isEmpty else {
            return
        }
        CreateAccountUseCase(authRepository: authRepository).execute(email: email, password: password) { result in
            switch result {
            case .success(let user):
                print(user.uid)
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    @IBAction func skipAuth(_ sender: Any) {
        let result = SkipAuthUseCase(authRepository: authRepository).execute()
        if result {
            print("Мы успешно вошли как гость")
        }
    }
}
