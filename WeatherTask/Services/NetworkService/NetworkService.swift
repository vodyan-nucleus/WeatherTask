//
//  NetworkService.swift
//  WeatherTask
//
//  Created by Евгений Водянович on 16.10.2021.
//

import Foundation

protocol NetworkServiceProtocol: AnyObject {
    func getWeatherInfo<T: Decodable>(linkBuilder: LinkBuilder, completion: @escaping (Result<T, Error>) -> Void)
}

class NetworkService: NetworkServiceProtocol{
    func getWeatherInfo<T>(linkBuilder: LinkBuilder, completion: @escaping (Result<T, Error>) -> Void) where T: Decodable {
        
        let urlString = linkBuilder.link
        
        guard let url = URL(string: urlString) else {return}
        
        URLSession.shared.dataTask(with: url) { data, _, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            do {
                let decoder = JSONDecoder()
                let obj = try decoder.decode(T.self, from: data!)
                completion(.success(obj))
            } catch {
                completion(.failure(error))
            }
        }.resume()
        }
}
