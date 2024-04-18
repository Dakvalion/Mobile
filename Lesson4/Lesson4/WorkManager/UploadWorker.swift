//
//  UploadWorker.swift
//  Lesson4
//
//  Created by Егор Бадмаев on 18.04.2024.
//

import Foundation

class UploadWorker: Operation {
    static let tag = "UploadWorker"
    
    var constraints: [() -> Bool] = []
    
    override func main() {
        let result = constraints.allSatisfy { constraint in
            constraint()
        }
        if result {
            print("\(UploadWorker.tag): doWork: start")
            sleep(5)
            print("\(UploadWorker.tag): doWork: end")
        } else {
            print("\(UploadWorker.tag): Conditions not met")
        }
    }
}
