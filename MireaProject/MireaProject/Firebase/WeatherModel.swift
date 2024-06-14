//
//  HttpURLConnectionModel.swift
//  Lesson7
//
//  Created by Дарья Никитина on 18.05.2024.
//

import Foundation

struct WeatherModel: Decodable {
    let latitude: Double
    let longitude: Double
    let utcOffsetSeconds: Int
    let timezone: String
    let timezoneAbbreviation: String
    let elevation: Int
    let currentWeatherUnits: CurrentWeatherUnits
    let currentWeather: CurrentWeather

    enum CodingKeys: String, CodingKey {
        case latitude, longitude
        case utcOffsetSeconds = "utc_offset_seconds"
        case timezone
        case timezoneAbbreviation = "timezone_abbreviation"
        case elevation
        case currentWeatherUnits = "current_weather_units"
        case currentWeather = "current_weather"
    }
}

struct CurrentWeather: Decodable {
    let time: String
    let interval: Int
    let temperature: Double
    let windspeed: Double
    let winddirection: Int
    let weathercode: Int
}

struct CurrentWeatherUnits: Decodable {
    let time: String
    let interval: String
    let temperature: String
    let windspeed: String
    let winddirection: String
    let weathercode: String
}
