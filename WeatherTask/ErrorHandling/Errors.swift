//
//  Error.swift
//  WeatherTask
//
//  Created by Евгений Водянович on 17.10.2021.
//

import Foundation

enum Errors {
    case network
    case location
    
    var title: String {
        switch self {
        case .network:
            return "Ошибка загрузки данных"
        case .location:
            return "Ошибка обновления местоположения"
        }
    }
    
    var body: String {
        switch self {
        case .network:
            return "Пожалуйста, проверьте интернет соединение или попробуйте позже"
        case .location:
            return "Не удалось получить данные о местоположении, попробуйте позже"
        }
    }
}
