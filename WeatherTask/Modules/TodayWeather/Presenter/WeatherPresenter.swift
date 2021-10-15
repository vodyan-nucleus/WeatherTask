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
    
    init(view: WeatherViewProtocol) {
        self.view = view
    }
}