//
//  LocationService.swift
//  WeatherTask
//
//  Created by Евгений Водянович on 16.10.2021.
//

import Foundation
import CoreLocation

protocol LocationServiceProtocol: AnyObject {
    func startUpdatingLocation()
    func getCurrentLocation() -> Location?
    var delegate: LocationServiceDelegate? { get set }
}

protocol LocationServiceDelegate: AnyObject { // Delegate protocol
    func didUpdateLocation()
    func didFailUpdateLocation()
}

class LocationService: NSObject, LocationServiceProtocol, CLLocationManagerDelegate{

    weak var delegate: LocationServiceDelegate?
    
    var locationManager = CLLocationManager()
    var location: Location?
    
    
    override init(){
        super.init()
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
    }
    

    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
            if let location = locations.last {
                if location.horizontalAccuracy > 0 {
                    locationManager.stopUpdatingLocation()
                    self.getPlace(for: location) { placemark in
                        guard let placemark = placemark else { return }
                        if let town = placemark.locality {
                            self.location = Location(lat: location.coordinate.latitude, lon: location.coordinate.latitude, city: town)
                        }
                        self.delegate?.didUpdateLocation()
                    }
                }
            }
        }

        func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
            print(error.localizedDescription)
            delegate?.didFailUpdateLocation()
        }
    
    func getPlace(for location: CLLocation,
                      completion: @escaping (CLPlacemark?) -> Void) {
            
            let geocoder = CLGeocoder()
            geocoder.reverseGeocodeLocation(location) { placemarks, error in
                
                guard error == nil else {
                    print("*** Error in \(#function): \(error!.localizedDescription)")
                    completion(nil)
                    self.delegate?.didFailUpdateLocation()
                    return
                }
                
                guard let placemark = placemarks?[0] else {
                    print("*** Error in \(#function): placemark is nil")
                    completion(nil)
                    self.delegate?.didFailUpdateLocation()
                    return
                }
                completion(placemark)
            }
        }
    
    func startUpdatingLocation() {
        locationManager.startUpdatingLocation()
    }
    
    func getCurrentLocation() -> Location? {
        guard let location = location else {return nil}
        return location
    }
}
