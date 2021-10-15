//
//  WeatherViewController.swift
//  WeatherTask
//
//  Created by Евгений Водянович on 15.10.2021.
//

import UIKit

class WeatherViewController: UIViewController {
    var presenter: WeatherViewPresenterProtocol!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}

//MARK: - WeatherViewProtocol
extension WeatherViewController: WeatherViewProtocol {
}
