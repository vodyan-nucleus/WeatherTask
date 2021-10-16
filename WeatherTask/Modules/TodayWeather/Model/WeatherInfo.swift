//
//  WeatherInfo.swift
//  WeatherTask
//
//  Created by Евгений Водянович on 15.10.2021.
//

import Foundation

struct WeatherInfo: Decodable {
    var current: Current
    var hourly: [Hourly]
}

//MARK: - Current Weather
struct Current: Decodable {
    let sunrise: Int
    let sunset: Int
    var temp: Double
    let feels_like: Double
    let pressure: Int
    let humidity: Double
    let clouds: Double
    let uvi: Double
    let visibility: Double
    let wind_speed: Double
    let wind_deg: Double
    let rain: Rain?
    var weather: [Weather]
    
}

struct Rain: Decodable {
    let the1h: Double?
    
    enum CodingKeys: String, CodingKey {
        case the1h = "1h"
    }
}

struct Weather: Decodable {
    let id: Int
    let main: String
    var description: String
    let icon: String
}

//MARK: - Hourly Forecast
struct Hourly: Decodable {
    let dt: Int
    let temp: Double
    var weather: [HourlyWeather]
}

struct HourlyWeather: Decodable{
    let icon: String
}
