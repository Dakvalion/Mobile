//
//  SensorListViewController.swift
//  Lesson5
//
//  Created by Дарья Никитина on 22.04.2024.
//

import UIKit
import SensorKit

class SensorListViewController: UITableViewController {
    
    var sensorList: [SRSensor] = [
        .accelerometer, .ambientLightSensor, .ambientPressure, .deviceUsageReport, .faceMetrics,
        .heartRate, .keyboardMetrics, .mediaEvents, .messagesUsageReport, .wristTemperature,
        .odometer, .onWristState, .pedometerData, .phoneUsageReport, .visits,
        .rotationRate, .siriSpeechMetrics, .telephonySpeechMetrics
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return sensorList.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        var configuration = cell.defaultContentConfiguration()
        configuration.text = sensorList[indexPath.row].rawValue
        cell.contentConfiguration = configuration
        return cell
    }
}
