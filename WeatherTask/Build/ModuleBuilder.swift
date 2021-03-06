//
//  ModuleBuilder.swift
//  WeatherTask
//
//  Created by Евгений Водянович on 15.10.2021.
//

import UIKit

protocol Builder {
    static func createTodayWeatherModule() -> UIViewController
    static func createDailyForecastModule() -> UIViewController
}

class ModuleBuilder: Builder {
    private static let networkService = NetworkService()
    private static let locationService = LocationService()
    
    static func createTodayWeatherModule() -> UIViewController {
        let view = WeatherViewController()
        let presenter = WeatherPresenter(view: view, networkService: networkService, locationService: locationService)
        view.presenter = presenter
        return view
    }
    
    static func createDailyForecastModule() -> UIViewController {
        let view = DailyForecastViewController()
        let presenter = DailyForecastPresenter(view: view, networkService: networkService, locationService: locationService)
        view.presenter = presenter
        return view
    }
}
