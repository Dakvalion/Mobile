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
        loginTextField.delegate = self
        passwordTextField.delegate = self
    }
    
    @objc func authStateChanged(_ notification: Notification) {
        if let success = notification.object as? Bool {
            if success {
                print("Успешная аутентификация - \(vm.user?.uid ?? "")")
                navigateToMainScreen()
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
            navigateToMainScreen()
        }
    }
    
    private func navigateToMainScreen() {
        let ingredientsVC = IngredientsViewController()
        let navigationController = UINavigationController(rootViewController: ingredientsVC)
        
        let detailVC = UIViewController()
        let detailNavigationController = UINavigationController(rootViewController: detailVC)
        
        let splitVC = UISplitViewController(style: .doubleColumn)
        splitVC.preferredDisplayMode = .oneBesideSecondary
        splitVC.setViewController(navigationController, for: .primary)
        splitVC.setViewController(detailNavigationController, for: .secondary)
        
        splitVC.presentsWithGesture = true
        splitVC.preferredSplitBehavior = .tile
        
        let profileVM = ViewModelFactory().createProfileViewModel()
        let profileVC = ProfileViewController(viewModel: profileVM)
        let profileNavigationController = UINavigationController(rootViewController: profileVC)
        
        let tabBarController = UITabBarController()
        tabBarController.viewControllers = [splitVC, profileNavigationController]
        
        splitVC.tabBarItem = UITabBarItem(title: "Ингредиенты", 
                                          image: UIImage(systemName: "volleyball.fill"),
                                          tag: 0)
        profileNavigationController.tabBarItem = UITabBarItem(title: "Профиль",
                                                              image: UIImage(systemName: "person.fill"),
                                                              tag: 0)
        
        guard let window = view.window else { return }
        window.rootViewController = tabBarController
        UIView.transition(with: window,
                          duration: 0.3,
                          options: .transitionCrossDissolve,
                          animations: nil,
                          completion: nil)
    }
    
}

extension LoginViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return false
    }
}
