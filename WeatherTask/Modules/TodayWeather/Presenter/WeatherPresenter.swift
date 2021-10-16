//
//  WeatherPresenter.swift
//  WeatherTask
//
//  Created by Евгений Водянович on 15.10.2021.
//

import Foundation

protocol WeatherViewProtocol: AnyObject {
    func success()
    func failure(error: Error)
}

protocol WeatherViewPresenterProtocol: AnyObject {
    var currentWeatherInfoModel: CurrentWeatherInfoModel? {get set}
    var hourlyForecastModel: [HourlyForecastModel]? {get set}
    func viewWillAppear()
    func configureBasicInfoTableViewCell(cell: BasicInfoCellProtocol)
    func configureAdvancedInfoTableViewCell(cell: AdvancedInfoCellProtocol, forRow row: Int)
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
    
    func viewWillAppear() {
        self.locationService?.startUpdatingLocation()
    }
    
    func didUpdateLocation() {
        getWeatherInfo()
    }
    
    func didFailUpdateLocation() {
        print("Error getting location")
    }
    
    func configureBasicInfoTableViewCell(cell: BasicInfoCellProtocol) {
        if let currentWeatherInfoModel = currentWeatherInfoModel{
            cell.display(iconName: currentWeatherInfoModel.weatherIcon, location: currentWeatherInfoModel.city, currentTemperatureAndDescription: currentWeatherInfoModel.currentTempretureAndDescription)
        }
    }
    
    func configureAdvancedInfoTableViewCell(cell: AdvancedInfoCellProtocol, forRow row: Int){
        guard let param = currentWeatherInfoModel?.paramArray[row] else { return }
        guard let value = currentWeatherInfoModel?.valueArray[row] else { return }
        cell.display(param: param, value: value)
    }
    
    func getWeatherInfo() {
        guard let currentLocation = locationService.getCurrentLocation() else { return }
        networkService.getWeatherInfo(linkBuilder: .getCurrentWeather(lat: currentLocation.lat, lon: currentLocation.lon)) { [weak self] (result: Result<WeatherInfo, Error>) in
            guard let self = self else {return}
            DispatchQueue.main.async {
                switch result {
                case .success(let weatherInfo):
                    self.currentWeatherInfoModel = CurrentWeatherInfoModel(currentWeatherData: weatherInfo.current, location: self.locationService.getCurrentLocation())
                    for index in weatherInfo.hourly{
                        let hourlyForecastModel = HourlyForecastModel(HourlyForecast: index)
                        if (self.hourlyForecastModel?.append(hourlyForecastModel)) == nil {
                            self.hourlyForecastModel = [hourlyForecastModel]
                        }
                    }
                    self.view?.success()
                case .failure(let error):
                    self.view?.failure(error: error)
                }
            }
        }
    }
}
