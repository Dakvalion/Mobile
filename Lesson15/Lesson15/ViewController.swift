//
//  ViewController.swift
//  Lesson15
//
//  Created by Daria Nikitina on 28.12.2024.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        title = "Главная страница"
    }
    
    @objc func openSettings() {
        let settingsScreen = SettingsViewController()
        navigationController?.pushViewController(settingsScreen, animated: true)
    }
}

class ProfileViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        title = "Профиль"
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "gear"),
                                                            style: .done,
                                                            target: self,
                                                            action: #selector(openSettings))
    }
    
    @objc func openSettings() {
        let settingsScreen = SettingsViewController()
        navigationController?.pushViewController(settingsScreen, animated: true)
    }
}

class SettingsViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        title = "Настройки пользователя"
    }
}
