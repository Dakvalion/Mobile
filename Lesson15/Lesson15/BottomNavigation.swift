//
//  BottomNavigation.swift
//  Lesson15
//
//  Created by Daria Nikitina on 29.12.2024.
//

import UIKit

class BottomNavigation: UITabBarController {
    override func viewDidLoad() {
        super.viewDidLoad()
        let mainController = UINavigationController(rootViewController: ViewController())
        let profileController = UINavigationController(rootViewController: ProfileViewController())
        mainController.navigationBar.prefersLargeTitles = true
        profileController.navigationBar.prefersLargeTitles = true
        mainController.tabBarItem = UITabBarItem(title: "Главная страница",
                                                 image: UIImage(systemName: "volleyball"),
                                                 tag: 0)
        profileController.tabBarItem = UITabBarItem(title: "Профиль",
                                                 image: UIImage(systemName: "person"),
                                                 tag: 0)
        let viewControllers: [UIViewController] = [mainController, profileController]
        setViewControllers(viewControllers, animated: true)
    }
}
