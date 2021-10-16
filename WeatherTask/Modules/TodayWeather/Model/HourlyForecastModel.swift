//
//  HourlyForecastModel.swift
//  WeatherTask
//
//  Created by Евгений Водянович on 16.10.2021.
//

import Foundation

import Foundation

struct HourlyForecastModel {
    let date: Int
    let temperature: Double
    let iconName: String
    
    init(HourlyForecast hourly: Hourly) {
        self.date = hourly.dt
        self.temperature = hourly.temp
        self.iconName = hourly.weather[0].icon
    }
    
    var timeString: String {
        let time = Date(timeIntervalSince1970: TimeInterval(date))
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "HH"
        return "\(dateFormatter.string(from: time))"
    }
    
    var temperatureString: String {
        let temperature = String(format: "%.0f", temperature) + "º"
        return temperature
    }
}
