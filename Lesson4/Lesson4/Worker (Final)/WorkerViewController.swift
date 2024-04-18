//
//  WorkerViewController.swift
//  Lesson4
//
//  Created by Егор Бадмаев on 18.04.2024.
//

import UIKit

class Worker: Operation {
    static let tag = "Worker"
    
    override func main() {
        print("\(Worker.tag): doWork: start")
        sleep(5)
        print("\(Worker.tag): doWork: end")
    }
}

class WorkerViewController: UIViewController {
    let operationQueue = OperationQueue()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let worker = Worker()
        worker.completionBlock = {
            print("\(Worker.tag): doWork: completed")
        }
        operationQueue.addOperation(worker)
    }
}
