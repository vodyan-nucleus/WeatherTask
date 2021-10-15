//
//  ModuleBuilder.swift
//  WeatherTask
//
//  Created by Евгений Водянович on 15.10.2021.
//

import UIKit

protocol Builder {
    static func createTodayWeatherModule() -> UIViewController
}

class ModuleBuilder: Builder {
    static func createTodayWeatherModule() -> UIViewController {
        let view = WeatherViewController()
        let presenter = WeatherPresenter(view: view)
        view.presenter = presenter
        return view
    }
}
