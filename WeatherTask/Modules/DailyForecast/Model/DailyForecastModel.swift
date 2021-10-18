//
//  DailyForecastModel.swift
//  WeatherTask
//
//  Created by Евгений Водянович on 17.10.2021.
//

import Foundation

struct DailyForecastModel {
    let date: Int
    let temperature: Double
    let description: String
    let weatherIcon: String
    
    init(dailyForecastData daily: List) {
        self.date = daily.dt
        self.temperature = daily.main.temp
        self.description = daily.weather[0].description.capitalizingFirstLetter()
        self.weatherIcon = daily.weather[0].icon
    }

    var time: String {
        let time = Date(timeIntervalSince1970: TimeInterval(date))
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "EE, HH:mm"
        dateFormatter.locale = Locale(identifier: "ru")
        return "\(dateFormatter.string(from: time))".capitalizingFirstLetter()
    }
    
    var temperatureString: String {
        return String(format: "%.0f", temperature)  + "°С"
    }
}
