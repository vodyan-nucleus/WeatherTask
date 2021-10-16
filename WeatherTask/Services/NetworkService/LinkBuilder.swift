//
//  LinkBuilder.swift
//  WeatherTask
//
//  Created by Евгений Водянович on 16.10.2021.
//

import Foundation

enum LinkBuilder {
    case getCurrentWeather(lat: Double, lon: Double)
    case getForecast(lat: Double, lon: Double)
    
    var link: String {
        switch self {
        case .getCurrentWeather(let lat, let lon):
            return "https://api.openweathermap.org/data/2.5/onecall?lat=\(lat)&lon=\(lon)&units=metric&lang=ru&exclude=minutely,alerts&appid=b63abaf7cf0719c35ddffdea2eaef9a8"
        case .getForecast(let lat, let lon):
            return "https://api.openweathermap.org/data/2.5/forecast?lat=\(lat)&lon=\(lon)&units=metric&lang=ru&appid=b63abaf7cf0719c35ddffdea2eaef9a8"
        }
    }
}
