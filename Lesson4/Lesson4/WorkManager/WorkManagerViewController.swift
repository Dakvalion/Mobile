//
//  WorkManagerViewController.swift
//  Lesson4
//
//  Created by Дарья Никитина on 14.04.2024.
//

import UIKit
import SystemConfiguration

class WorkManagerViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let uploadWorker = UploadWorker()
        uploadWorker.constraints = [
            {
                var zeroAddress = sockaddr_in()
                zeroAddress.sin_len = UInt8(MemoryLayout.size(ofValue: zeroAddress))
                zeroAddress.sin_family = sa_family_t(AF_INET)
                
                let defaultRouteReachability = withUnsafePointer(to: &zeroAddress) {
                    $0.withMemoryRebound(to: sockaddr.self, capacity: 1) { zeroSockAddress in
                        SCNetworkReachabilityCreateWithAddress(nil, zeroSockAddress)
                    }
                }
                
                var flags: SCNetworkReachabilityFlags = []
                if !SCNetworkReachabilityGetFlags(defaultRouteReachability!, &flags) {
                    return false
                }
                let isReachable = (flags.rawValue & UInt32(kSCNetworkFlagsReachable)) != 0
                let needsConnection = (flags.rawValue & UInt32(kSCNetworkFlagsConnectionRequired)) != 0
                return (isReachable && !needsConnection)
            },
            {
                UIDevice.current.isBatteryMonitoringEnabled = true
                // Предположим, что устройство заряжается, если уровень заряда ниже 90%
                return UIDevice.current.batteryLevel < 0.9
            }
        ]
        let operationQueue = OperationQueue()
        operationQueue.addOperation(uploadWorker)
    }
}
