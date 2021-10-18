//
//  WeatherPresenter.swift
//  WeatherTask
//
//  Created by Евгений Водянович on 15.10.2021.
//

import Foundation

protocol WeatherViewProtocol: AnyObject {
    func success()
    func failure(error: Errors)
    func showActivityController(message: String)
}

protocol WeatherViewPresenterProtocol: AnyObject {
    var currentWeatherInfoModel: CurrentWeatherInfoModel? {get set}
    var hourlyForecastModel: [HourlyForecastModel]? {get set}
    func viewWillAppear()
    func viewWillDisappear()
    func sharePressed()
    func retryPressed()
    func configureBasicInfoCell(cell: BasicInfoCellProtocol)
    func configureAdvancedInfoCell(cell: AdvancedInfoCellProtocol, forRow row: Int)
    func configureHourlyForecastCell(cell: HourlyForecastCellProtocol, forRow row: Int)
}

class WeatherPresenter: WeatherViewPresenterProtocol{
    
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
    }
    
    func viewWillAppear() {
        getCurrentLocation()
    }
    
    func viewWillDisappear() {
        currentWeatherInfoModel = nil
        hourlyForecastModel = nil
    }
    
    func sharePressed() {
        if var currentWeatherInfoModel = currentWeatherInfoModel {
            view?.showActivityController(message: currentWeatherInfoModel.shareMessage)
        }
    }
    
    func retryPressed() {
        getCurrentLocation()
    }
    
    func configureBasicInfoCell(cell: BasicInfoCellProtocol) {
        if let currentWeatherInfoModel = currentWeatherInfoModel{
            cell.display(iconName: currentWeatherInfoModel.weatherIcon, location: currentWeatherInfoModel.city, currentTemperatureAndDescription: currentWeatherInfoModel.currentTempretureAndDescription)
        }
    }
    
    func configureAdvancedInfoCell(cell: AdvancedInfoCellProtocol, forRow row: Int){
        guard let param = currentWeatherInfoModel?.paramArray[row] else { return }
        guard let value = currentWeatherInfoModel?.valueArray[row] else { return }
        cell.display(param: param, value: value)
    }
    
    func configureHourlyForecastCell(cell: HourlyForecastCellProtocol, forRow row: Int){
        if let hourlyForecastModel = hourlyForecastModel{
            cell.display(time: hourlyForecastModel[row].timeString, temperature: hourlyForecastModel[row].temperatureString, image: hourlyForecastModel[row].iconName)
        }
    }
    
    func getCurrentLocation() {
        self.locationService?.startUpdatingLocation(complition: { [weak self] error in
            guard let self = self else {return}
            if error == nil {
                guard let lastLocation = self.locationService.getLastLocation() else { return }
                self.getWeatherInfo(location: lastLocation)
            } else {
                switch (error! as NSError).code {
                case 2:
                    self.view?.failure(error: .network)
                default:
                    self.view?.failure(error: .location)
                }
            }
        })
    }
    
    func getWeatherInfo(location: Location) {
        networkService.getWeatherInfo(linkBuilder: .getCurrentWeather(lat: location.lat, lon: location.lon)) { [weak self] (result: Result<WeatherInfo, Error>) in
            guard let self = self else {return}
            DispatchQueue.main.async {
                switch result {
                case .success(let weatherInfo):
                    self.currentWeatherInfoModel = CurrentWeatherInfoModel(currentWeatherData: weatherInfo.current, location: location)
                    for index in weatherInfo.hourly{
                        let hourlyForecastModel = HourlyForecastModel(HourlyForecast: index)
                        if (self.hourlyForecastModel?.append(hourlyForecastModel)) == nil {
                            self.hourlyForecastModel = [hourlyForecastModel]
                        }
                    }
                    self.view?.success()
                case .failure(let error):
                    print(error.localizedDescription)
                    self.view?.failure(error: Errors.network)
                }
            }
        }
    }
}
