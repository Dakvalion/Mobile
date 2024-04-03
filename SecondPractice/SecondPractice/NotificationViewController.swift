//
//  NotificationViewController.swift
//  SecondPractice
//
//  Created by Егор Бадмаев on 03.04.2024.
//

import UIKit
import UserNotifications

class NotificationViewController: UIViewController {
    @IBOutlet weak var textField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        UNUserNotificationCenter.current().requestAuthorization(
            options: [.alert, .badge, .sound]
        ) { success, error in
            if success {
                print("Разрешение на уведомления получено")
            } else if let error = error {
                print("Ошибка при запросе разрешения: \(error.localizedDescription)")
            }
        }
    }
    
    @IBAction func submitButtonAction(_ sender: Any) {
        let alertController = UIAlertController(
            title: "Toast",
            message: "СТУДЕНТ №17 ГРУППА БСБО-10-21 Количество символов - \(textField.text?.count ?? 0)",
            preferredStyle: .alert
        )
        let okAction = UIAlertAction(title: "OK", style: .default) { _ in }
        alertController.addAction(okAction)
        
        present(alertController, animated: true, completion: nil)
    }
    
    @IBAction func sendNotificationButton(_ sender: Any) {
        let content = UNMutableNotificationContent()
        content.title = "Mirea"
        content.body = "Congratulation!"
        content.sound = UNNotificationSound.default
        
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 5, repeats: false)
        let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: trigger)
        
        UNUserNotificationCenter.current().add(request) { error in
            if let error = error {
                print("Ошибка при добавлении уведомления: \(error.localizedDescription)")
            }
        }
    }
    
    @IBAction func dialogButtonAction(_ sender: Any) {
        let alertController = UIAlertController(title: "Введите пароль", message: nil, preferredStyle: .alert)
        
        alertController.addTextField { textField in
            textField.placeholder = "Пароль"
            textField.isSecureTextEntry = true
        }
        
        let okAction = UIAlertAction(title: "OK", style: .default) { _ in
            if let password = alertController.textFields?.first?.text {
                print("Вы ввели пароль: \(password)")
            }
        }
        
        alertController.addAction(okAction)
        
        present(alertController, animated: true, completion: nil)
    }
}
