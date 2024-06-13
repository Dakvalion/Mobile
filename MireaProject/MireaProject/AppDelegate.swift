//
//  AppDelegate.swift
//  MireaProject
//
//  Created by Дарья Никитина on 13.06.2024.
//

import UIKit
import BackgroundTasks
import FirebaseCore
import YandexMapsMobile

@main
class AppDelegate: UIResponder, UIApplicationDelegate {



    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        YMKMapKit.setApiKey("24ff20b5-14a6-464a-8176-b2a1e6acea99")
        YMKMapKit.sharedInstance()
        BGTaskScheduler.shared.register(forTaskWithIdentifier: "notifyUser", using: nil) { task in
            guard let task = task as? BGAppRefreshTask else { return }
            self.createTask(task: task)
        }
        FirebaseApp.configure()
        return true
    }
    
    func applicationDidEnterBackground(_ application: UIApplication) {
        scheduleAppRefresh()
    }
    
    func createTask(task: BGAppRefreshTask) {
        Task {
            let content = UNMutableNotificationContent()
            content.title = "Mirea"
            content.body = "Давно тебя не было в уличных гонках! Заходи!"
            content.sound = UNNotificationSound.default
            
            let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 5, repeats: false)
            let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: trigger)
            
            do {
                try await UNUserNotificationCenter.current().add(request)
                let currentCounter = UserDefaults.standard.integer(forKey: "notifyUserCounter")
                UserDefaults.standard.set(currentCounter + 1, forKey: "notifyUserCounter")
                task.setTaskCompleted(success: true)
                scheduleAppRefresh()
            } catch {
                print("Ошибка при добавлении уведомления: \(error.localizedDescription)")
            }
        }
    }
    
    func scheduleAppRefresh() {
        let request = BGAppRefreshTaskRequest(identifier: "notifyUserCounter")
        request.earliestBeginDate = Date(timeIntervalSinceNow: 10)
        
        do {
            try BGTaskScheduler.shared.submit(request)
        } catch {
            print("Could not schedule app refresh: \(error)")
        }
    }

    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }


}

