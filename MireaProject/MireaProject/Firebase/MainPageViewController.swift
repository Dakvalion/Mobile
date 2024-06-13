//
//  MainPageViewController.swift
//  Lesson7
//
//  Created by Дарья Никитина on 18.05.2024.
//

import UIKit
import FirebaseAuth

class MainPageViewController: UIViewController {
    
    @IBOutlet weak var weatherLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        guard let weatherURL = URL(
            string: "https://api.open-meteo.com/v1/forecast?latitude=52.52&longitude=13.41&current_weather=true"
        ) else { return }
        let weatherRequest = URLRequest(url: weatherURL)
        let weatherTask = URLSession.shared.dataTask(with: weatherRequest) { [weak self] weatherData, _, _ in
            guard let self,
                  let weatherData else { return }
            do {
                let weather = try JSONDecoder().decode(WeatherModel.self, from: weatherData)
                DispatchQueue.main.async {
                    self.weatherLabel.text = "Температура сейчас: \(weather.currentWeather.temperature) ℃"
                }
            } catch {
                print("‼️ Ошибка при декодировании ответа от сервиса погоды", error)
            }
        }
        weatherTask.resume()
    }
    
    @IBAction func logoutButtonTapped(_ sender: Any) {
        do {
            try Auth.auth().signOut()
            dismiss(animated: true)
        } catch {
            print("Ошибка при выходе: \(error.localizedDescription)")
        }
    }
}
