//
//  DetailInteractor.swift
//  Weather App
//
//  Created by User on 10/13/19.
//  Copyright © 2019 VK. All rights reserved.
//

import UIKit

class DetailInteractor: DetailPresenterToInteractorProtocol {
    let defaultSession = URLSession(configuration: .default)
    var dataTask: URLSessionDataTask?
    var presenter: DetailInteractorToPresenterProtocol?
    
    func getCurrentWeatherData(by cityName: String) {
        
    }
    
}
