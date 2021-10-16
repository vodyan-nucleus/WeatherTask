//
//  WeatherPresenter.swift
//  WeatherTask
//
//  Created by Евгений Водянович on 15.10.2021.
//

import Foundation

protocol WeatherViewProtocol: AnyObject {
}

protocol WeatherViewPresenterProtocol: AnyObject {
    
}

class WeatherPresenter: WeatherViewPresenterProtocol{
    weak var view: WeatherViewProtocol?
    let networkService: NetworkServiceProtocol!
    
    var weatherInfo: WeatherInfo?
    var currentWeatherInfoModel: CurrentWeatherInfoModel?
    var hourlyForecastModel: [HourlyForecastModel]?
    
    init(view: WeatherViewProtocol, networkService: NetworkServiceProtocol) {
        self.view = view
        self.networkService = networkService
    }
}
