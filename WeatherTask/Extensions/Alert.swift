//
//  Alert.swift
//  WeatherTask
//
//  Created by Евгений Водянович on 17.10.2021.
//

import UIKit

extension UIViewController {
    func showAlert(title: String, message: String, handler: @escaping (UIAlertAction) -> Void) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let retryAction = UIAlertAction(title: "Повторить попытку", style: .default, handler: handler)
        alert.addAction(retryAction)
        present(alert, animated: true, completion: nil)
    }
}
