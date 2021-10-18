//
//  ActivityIndicator.swift
//  WeatherTask
//
//  Created by Евгений Водянович on 17.10.2021.
//

import UIKit

fileprivate var aView: UIView?

extension UIViewController {
    
    func startSpinner() {
        aView = UIView(frame: self.view.bounds)
        aView?.backgroundColor = .systemCyan
        let activityIndicator = UIActivityIndicatorView(style: .large)
        activityIndicator.color = .white
        activityIndicator.center = aView!.center
        activityIndicator.startAnimating()
        aView?.addSubview(activityIndicator)
        self.view.addSubview(aView!)
    }
    
    func stopSpinner() {
        aView?.removeFromSuperview()
        aView = nil
    }
}
