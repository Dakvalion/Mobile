//
//  MyLooper.swift
//  Lesson4
//
//  Created by Егор Бадмаев on 14.04.2024.
//

import Foundation

class MyLooper {
    public var mHandler: (() -> (Int, String))?
    
    private var queue: DispatchQueue
    private var mainHandler: (String) -> Void
    
    init(mainThreadHandler: @escaping (String) -> Void) {
        self.mainHandler = mainThreadHandler
        self.queue = DispatchQueue(label: "ru.nikitina.mylooper")
    }
    
    func start() {
        queue.async {
            print("MyLooper run")
            guard let result = self.mHandler?() else { return }
            self.handleMessage(age: result.0, grade: result.1)
        }
    }
    
    private func handleMessage(age: Int, grade: String) {
        print("Looper получил сообщение. Возраст: \(age), должность: \(grade)")
        sleep(UInt32(age))
        let result = "Мой возраст - \(age) лет, моя должность - \(grade)"
        DispatchQueue.main.async {
            self.mainHandler(result)
        }
    }
}
