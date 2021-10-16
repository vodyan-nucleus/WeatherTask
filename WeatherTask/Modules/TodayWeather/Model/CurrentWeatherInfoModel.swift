//
//  CurrentWeatherInfoModel.swift
//  WeatherTask
//
//  Created by Евгений Водянович on 16.10.2021.
//

import Foundation

struct CurrentWeatherInfoModel {
    let city: String
    let description: String
    let temperature: Double
    let feelsLikeTemp: String
    private let sunrize: Int
    private let sunset: Int
    private let pressure: Int
    let humidity: String
    let clouds: String
    let uvi: String
    private let visibility: Double
    private let windSpeed: Double
    private let windDegrees: Double
    let rain: String
    let weatherIcon: String
    
    init(currentWeatherData current: Current, location: Location?) {
        self.city = location!.city
        self.description = current.weather[0].description.capitalizingFirstLetter()
        self.temperature = current.temp
        self.feelsLikeTemp = String(format: "%.0f", current.feels_like) + "º"
        self.sunrize = current.sunrise
        self.sunset = current.sunset
        self.pressure = current.pressure
        self.humidity = String(format: "%.0f", current.humidity) + "%"
        self.clouds = String(format: "%.0f", current.clouds) + "%"
        self.uvi = String(format: "%.0f", current.uvi)
        self.visibility = current.visibility
        self.windSpeed = current.wind_speed
        self.windDegrees = current.wind_deg
        self.rain = String(format: "%.0f", current.rain?.the1h ?? 0) + " мм"
        self.weatherIcon = current.weather[0].icon
    }
    
    var currentTempretureAndDescription: String {
        let temperature = String(format: "%.0f", temperature)
        return "\(temperature)°С | \(description)"
    }
    
    var sunrizeTimeString: String {
        let time = Date(timeIntervalSince1970: TimeInterval(sunrize))
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "HH:mm"
        return "\(dateFormatter.string(from: time))"
    }
    
    var sunsetTimeString: String {
        let time = Date(timeIntervalSince1970: TimeInterval(sunset))
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "HH:mm"
        return "\(dateFormatter.string(from: time))"
    }
    
    var pressureString: String {
        let pressure = Double(pressure) * 0.75006375541921
        return String(format: "%.2f", pressure) + " мм рт. ст."
    }
    
    var visibilityString: String {
        let visibility = String(format: "%.1f", visibility/1000) + " км"
        return visibility
    }
    
    var windString: String {
        let direction: String
        switch windDegrees{
        case 22.5...67.4:
            direction = "CВ"
        case 67.5...112.4:
            direction = "В"
        case 112.5...157.4:
            direction = "ЮВ"
        case 157.5...202.4:
            direction = "Ю"
        case 202.5...247.4:
            direction = "ЮЗ"
        case 247.5...292.4:
            direction = "З"
        case 292.5...337.4:
            direction = "СЗ"
        default:
            direction = "С"
        }
        return direction + " " + String(format: "%.1f", windSpeed) + " м/с"
    }

    lazy var valueArray = [sunrizeTimeString, sunsetTimeString, clouds, humidity, windString, rain, feelsLikeTemp, pressureString, visibilityString, uvi]
    
    let paramArray = ["ВОСХОД СОЛНЦА", "ЗАХОД СОЛНЦА", "ОБЛАЧНОСТЬ", "ВЛАЖНОСТЬ", "ВЕТЕР", "ОСАДКИ", "ОЩУЩАЕТСЯ КАК", "ДАВЛЕНИЕ", "ВИДИМОСТЬ", "УФ-ИНДЕКС"]
}
