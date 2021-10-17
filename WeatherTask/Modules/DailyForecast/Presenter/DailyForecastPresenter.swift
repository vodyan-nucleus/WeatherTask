//
//  DailyForecastPresenter.swift
//  WeatherTask
//
//  Created by Евгений Водянович on 17.10.2021.
//

import Foundation

protocol DailyForecastViewProtocol: AnyObject {
    func success()
    func failure(error: Error)
}

protocol DailyForecastPresenterProtocol: AnyObject {
    func viewDidAppear()
    func viewWillDisappear()
    func getCountOfTimeStamps() -> Int
    var dailyForecastModel: [DailyForecastModel]? { get }
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
    
    func getCountOfTimeStamps() -> Int {
        guard let dailyForecastModel = dailyForecastModel else {return 8}
        return dailyForecastModel.count - 32
    }
    
    func getDailyForecastData() {
        guard let currentLocation = locationService.getCurrentLocation() else { return }
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
                    self.view?.failure(error: error)
                    print(error)
                }
            }
        }
    }
}
