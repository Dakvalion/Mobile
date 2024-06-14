//
//  WorkerViewController.swift
//  Lesson4
//
//  Created by Дарья Никитина on 14.04.2024.
//

import UIKit
import BackgroundTasks
import UserNotifications

final class WorkerViewController: UIViewController {
    
    @IBOutlet weak var label: UILabel!
    
    let worker = Worker()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        UNUserNotificationCenter.current().requestAuthorization(
            options: [.alert, .badge, .sound]
        ) { success, error in
            if success {
                print("Разрешение на уведомления получено")
            } else if let error {
                print("Ошибка при запросе разрешения: \(error.localizedDescription)")
            }
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        let counter = UserDefaults.standard.integer(forKey: "notifyUserCounter")
        label.text = "Количество отправленных пушей: \(counter)"
        
        worker.runBackgroundTask(task: {
            let content = UNMutableNotificationContent()
            content.title = "MireaProject"
            content.body = "Давно тебя не было в уличных гонках"
            content.sound = UNNotificationSound.default
            
            let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 5, repeats: false)
            let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: trigger)
            
            UNUserNotificationCenter.current().add(request) { error in
                if let error = error {
                    print("Ошибка при добавлении уведомления: \(error.localizedDescription)")
                }
                UserDefaults.standard.set(counter + 1, forKey: "notifyUserCounter")
            }
        })
    }
}
