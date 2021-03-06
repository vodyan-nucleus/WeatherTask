//
//  DailyForecastPresenter.swift
//  WeatherTask
//
//  Created by Евгений Водянович on 17.10.2021.
//

import Foundation

protocol DailyForecastViewProtocol: AnyObject {
    func success()
    func failure(error: Errors)
}

protocol DailyForecastPresenterProtocol: AnyObject {
    func viewDidAppear()
    func viewWillDisappear()
    func retryPressed()
    func configureDailyForecastCell(cell: DailyForecastCellProtocol, forRow row: Int)
}

class DailyForecastPresenter: DailyForecastPresenterProtocol{
    
    weak var view: DailyForecastViewProtocol?
    let networkService: NetworkServiceProtocol!
    var locationService: LocationServiceProtocol!
    
    var dailyForecastData: DailyForecastData?
    var dailyForecastModel: [DailyForecastModel]?
    
    
    init(view: DailyForecastViewProtocol, networkService: NetworkServiceProtocol, locationService: LocationServiceProtocol) {
        self.view = view
        self.networkService = networkService
        self.locationService = locationService
    }
    
    func viewDidAppear() {
        getDailyForecastData()
    }
    
    func viewWillDisappear() {
        dailyForecastModel = nil
    }
    
    func retryPressed() {
        getDailyForecastData()
    }
    
    func configureDailyForecastCell(cell: DailyForecastCellProtocol, forRow row: Int) {
        if let dailyForecastModel = dailyForecastModel{
            cell.display(time: dailyForecastModel[row].time, description: dailyForecastModel[row].description, temperature: dailyForecastModel[row].temperatureString, image: dailyForecastModel[row].weatherIcon)
        }
    }
    
    func getDailyForecastData() {
        guard let currentLocation = locationService.getLastLocation() else { return }
        networkService.getWeatherInfo(linkBuilder: .getForecast(lat: currentLocation.lat, lon: currentLocation.lon)) { [weak self] (result: Result<DailyForecastData, Error>) in
            guard let self = self else {return}
            DispatchQueue.main.async {
                switch result {
                case .success(let dailyForecastData):
                    for index in dailyForecastData.list{
                        let dailyForecastModel = DailyForecastModel(dailyForecastData: index)
                        if (self.dailyForecastModel?.append(dailyForecastModel)) == nil {
                            self.dailyForecastModel = [dailyForecastModel]
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
