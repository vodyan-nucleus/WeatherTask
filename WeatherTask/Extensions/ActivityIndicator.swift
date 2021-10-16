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
        aView?.backgroundColor = .systemBackground
        let ai = UIActivityIndicatorView(style: .large)
        ai.center = aView!.center
        ai.startAnimating()
        aView?.addSubview(ai)
        self.view.addSubview(aView!)
    }
    
    func stopSpinner() {
        aView?.removeFromSuperview()
        aView = nil
    }
}
