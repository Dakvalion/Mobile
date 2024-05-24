//
//  FirebaseAuthViewController.swift
//  Lesson7
//
//  Created by Дарья Никитина on 18.05.2024.
//

import UIKit
import FirebaseAuth

class FirebaseAuthViewController: UIViewController {
    
    @IBOutlet weak var statusLabel: UILabel!
    @IBOutlet weak var uidLabel: UILabel!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var verifyEmailButton: UIButton!
    
    lazy var logoutButton = UIBarButtonItem(title: "Выйти", style: .done, target: self, action: #selector(signOut))
    
    var mAuth: Auth?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.rightBarButtonItem = logoutButton
        mAuth = Auth.auth()
        logoutButton.isEnabled = mAuth?.currentUser == nil
        updateUI(user: mAuth?.currentUser)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        updateUI(user: mAuth?.currentUser)
    }
    
    @IBAction func signUpButtonTapped(_ sender: Any) {
        guard let email = emailTextField.text, !email.isEmpty,
              let password = passwordTextField.text, !password.isEmpty else {
            showToast(title: "Заполните все поля формы", message: "")
            return
        }
        createAccount(email: email, password: password)
    }
    
    @IBAction func signInButtonTapped(_ sender: Any) {
        guard let email = emailTextField.text, !email.isEmpty,
              let password = passwordTextField.text, !password.isEmpty else {
            showToast(title: "Заполните все поля формы", message: "")
            return
        }
        signIn(email: email, password: password)
    }
    
    @IBAction func verifyEmailButtonTapped(_ sender: Any) {
        sendEmailVerification()
    }
    
    func createAccount(email: String, password: String) {
        mAuth?.createUser(withEmail: email, password: password) { [weak self] (result, error) in
            if let error = error {
                self?.showToast(title: "Невозможно создать аккаунт", message: "createUserAccount:fail \(error.localizedDescription)")
                self?.updateUI(user: nil)
            } else {
                print("createAccount:success", result?.user.uid ?? "")
                self?.updateUI(user: result?.user)
            }
        }
    }
    
    func signIn(email: String, password: String) {
        mAuth?.signIn(withEmail: email, password: password) { [weak self] (result, error) in
            if let error = error {
                print("signIn:fail \(error.localizedDescription)")
                self?.showToast(title: "Невозможно войти", message: "signIn:fail \(error.localizedDescription)")
                self?.updateUI(user: nil)
            } else {
                print("signIn:success", result?.user.uid ?? "")
                self?.updateUI(user: result?.user)
            }
        }
    }
    
    @objc func signOut() {
        do {
            try mAuth?.signOut()
            updateUI(user: nil)
        } catch let error {
            showToast(title: "Не удалось выйти", message: "\(error.localizedDescription)")
            print("Не удалось выйти: \(error.localizedDescription)")
        }
    }
    
    @objc func sendEmailVerification() {
        if let user = mAuth?.currentUser {
            user.sendEmailVerification { [weak self] (error) in
                if let error = error {
                    print("sendEmailVerification \(error.localizedDescription)")
                    self?.showToast(title: "Невозможно подтвердить почту", message: "Ошибка при подтверждении почты \(user.email ?? "")")
                } else {
                    print("Письмо с подтверждением отправлено на \(user.email ?? "") \(user.uid)")
                    self?.showToast(title: "Подтверждение отправлено", message: "Проверьте указанный почтовый ящик. Туда должна прийти ссылка для подтверждения")
                    self?.updateUI(user: self?.mAuth?.currentUser)
                }
            }
        }
    }
    
    func updateUI(user: User?) {
        if let user = user {
            statusLabel.text = "Email: \(user.email ?? ""), Verified: \(user.isEmailVerified)"
            uidLabel.text = "Firebase UID: \(user.uid)"
            logoutButton.isEnabled = true
            verifyEmailButton.isHidden = user.isEmailVerified
        } else {
            uidLabel.text = nil
            statusLabel.text = "Sign Out"
            logoutButton.isEnabled = false
            verifyEmailButton.isHidden = true
        }
    }
    
    func showToast(title: String, message: String) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        present(alertController, animated: true)
    }
}
