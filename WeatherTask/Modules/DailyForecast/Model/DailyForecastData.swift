//
//  DailyForecastData.swift
//  WeatherTask
//
//  Created by Евгений Водянович on 17.10.2021.
//

import Foundation

struct DailyForecastData: Decodable {
    let list: [List]
}

struct List: Decodable {
    let dt: Int
    let main: Main
    let weather: [DailyForecastWeather]
}

struct Main: Decodable {
    let temp: Double
}

struct DailyForecastWeather: Decodable {
    let description: String
    let icon: String
}
