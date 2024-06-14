//
//  Worker.swift
//  Lesson4
//
//  Created by Дарья Никитина on 03.06.2024.
//

import Foundation

class Worker {
    let backgroundQueue = DispatchQueue(label: "com.myApp.backgroundQueue")
    
    func runBackgroundTask(task: @escaping () -> ()) {
        backgroundQueue.async {
            task()
            print("Running background task...")
        }
    }
}
