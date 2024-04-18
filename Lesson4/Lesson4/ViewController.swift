//
//  ViewController.swift
//  Lesson4
//
//  Created by Егор Бадмаев on 31.03.2024.
//

import UIKit
import SwiftUI

class ViewController: UIViewController {

    func addBindingView(_ bindingView: some View) {
        let controller = UIHostingController(rootView: bindingView)
        controller.view.translatesAutoresizingMaskIntoConstraints = false
        controller.view.backgroundColor = .clear
        view.addSubview(controller.view)
        
        NSLayoutConstraint.activate([
            controller.view.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            controller.view.topAnchor.constraint(equalTo: view.topAnchor),
            controller.view.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            controller.view.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
}
