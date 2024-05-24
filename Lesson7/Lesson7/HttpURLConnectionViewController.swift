//
//  HttpURLConnectionViewController.swift
//  Lesson7
//
//  Created by Дарья Никитина on 18.05.2024.
//

import UIKit

class HttpURLConnectionViewController: UIViewController {
    
    var ipUrl = URL(string: "https://api.ipify.org")
    
    @IBOutlet weak var latitudeLabel: UILabel!
    @IBOutlet weak var longitudeLabel: UILabel!
    @IBOutlet weak var timezoneLabel: UILabel!
    @IBOutlet weak var temperatureLabel: UILabel!
    @IBOutlet weak var windSpeedLabel: UILabel!
    @IBOutlet weak var windDirectionLabel: UILabel!
    @IBOutlet weak var weatherCodeLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(
            image: UIImage(systemName: "thermometer.variable.and.figure"),
            style: .plain,
            target: self,
            action: #selector(makeRequest)
        )
    }
    
    @objc func makeRequest() {
        guard let ipUrl else { return }
        
        let ipRequest = URLRequest(url: ipUrl)
        
        let ipTask = URLSession.shared.dataTask(with: ipRequest) { [weak self] data, _, _ in
            guard let self,
                  let data,
                  let ip = String(data: data, encoding: .utf8)
            else { return }
            let components = ip.split(separator: ".")
            let latitude = String(((Int(components[0]) ?? 0) - 90)) + "." + components[1]
            let longitude = String(components[2] + "." + components[3])
            print("Latitude:", latitude, "Longitude:", longitude)
            let weatherURL = URL(
                string: "https://api.open-meteo.com/v1/forecast?latitude=\(latitude)&longitude=\(longitude)&current_weather=true"
            )
            guard let weatherURL else { return }
            let weatherRequest = URLRequest(url: weatherURL)
            let weatherTask = URLSession.shared.dataTask(with: weatherRequest) { weatherData, _, _ in
                guard let weatherData else { return }
                do {
                    let weather = try JSONDecoder().decode(WeatherModel.self, from: weatherData)
                    DispatchQueue.main.async {
                        self.latitudeLabel.text = latitude
                        self.longitudeLabel.text = longitude
                        self.timezoneLabel.text = weather.timezone
                        self.temperatureLabel.text = "\(weather.currentWeather.temperature) \(weather.currentWeatherUnits.temperature)"
                        self.windSpeedLabel.text = "\(weather.currentWeather.windspeed) \(weather.currentWeatherUnits.windspeed)"
                        self.windDirectionLabel.text = "\(weather.currentWeather.winddirection) \(weather.currentWeatherUnits.winddirection)"
                        self.weatherCodeLabel.text = "\(weather.currentWeather.weathercode) \(weather.currentWeatherUnits.weathercode)"
                    }
                } catch {
                    print("‼️ Ошибка при декодировании ответа от сервиса погоды", error)
                }
            }
            weatherTask.resume()
        }
        ipTask.resume()
    }
}
