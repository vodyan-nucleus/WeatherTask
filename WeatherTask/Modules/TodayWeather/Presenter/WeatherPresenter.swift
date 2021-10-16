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

class WeatherPresenter: WeatherViewPresenterProtocol, LocationServiceDelegate{
    
    weak var view: WeatherViewProtocol?
    let networkService: NetworkServiceProtocol!
    let locationService: LocationServiceProtocol!
    
    var weatherInfo: WeatherInfo?
    var currentWeatherInfoModel: CurrentWeatherInfoModel?
    var hourlyForecastModel: [HourlyForecastModel]?
    
    init(view: WeatherViewProtocol, networkService: NetworkServiceProtocol, locationService: LocationServiceProtocol) {
        self.view = view
        self.networkService = networkService
        self.locationService = locationService
        self.locationService.delegate = self
    }
    
    func didUpdateLocation() {
        
    }
    
    func didFailUpdateLocation() {
        
    }
}
