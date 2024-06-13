//
//  ImageRotatorViewController.swift
//  Lesson5
//
//  Created by Дарья Никитина on 24.04.2024.
//

import UIKit
import CoreMotion

final class ImageRotatorViewController: UIViewController {
    
    let motionManager = CMMotionManager()
    lazy var imageView: UIImageView = UIImageView(frame: CGRect(x: 50, y: 150, width: 100, height: 100))
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        imageView.backgroundColor = UIColor.systemPink
        view.addSubview(imageView)
        
        if motionManager.isGyroAvailable {
            motionManager.gyroUpdateInterval = 0.1
            motionManager.startGyroUpdates(to: OperationQueue.main) { (gyroData, error) in
                if let rotationRate = gyroData?.rotationRate {
                    self.rotateView(rotationRate)
                }
            }
        } else {
            print("Гироскоп недоступен")
        }
    }
    
    func rotateView(_ rotationRate: CMRotationRate) {
        let rotationRateX = CGFloat(rotationRate.x)
        let rotationRateY = CGFloat(rotationRate.y)
        
        UIView.animate(withDuration: 0.1) {
            self.imageView.transform = self.imageView.transform.rotated(by: rotationRateX)
            self.imageView.transform = self.imageView.transform.rotated(by: -rotationRateY)
        }
    }
}
