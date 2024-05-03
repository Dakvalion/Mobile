//
//  AccelerometerViewController.swift
//  Lesson5
//
//  Created by Дарья Никитина on 22.04.2024.
//

import CoreMotion
import UIKit

final class AccelerometerViewController: UIViewController {
    
    @IBOutlet weak var xLabel: UILabel!
    @IBOutlet weak var yLabel: UILabel!
    @IBOutlet weak var zLabel: UILabel!
    
    private let motion = CMMotionManager()
    private let queue = OperationQueue()
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if motion.isDeviceMotionAvailable {
            motion.startAccelerometerUpdates(to: queue) { data, error in
                if let data {
                    DispatchQueue.main.async {
                        self.xLabel.text = "\(data.acceleration.x)"
                        self.yLabel.text = "\(data.acceleration.z)"
                        self.zLabel.text = "\(data.acceleration.y)"
                    }
                }
            }
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        if motion.isDeviceMotionAvailable {
            motion.stopAccelerometerUpdates()
        }
    }
}
