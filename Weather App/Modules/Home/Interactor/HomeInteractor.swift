//
//  HomeInteractor.swift
//  Weather App
//
//  Created by User on 10/12/19.
//  Copyright © 2019 VK. All rights reserved.
//

import UIKit

class HomeInteractor: HomePresenterToInteractorProtocol {
    
    let defaultSession = URLSession(configuration: .default)
    var dataTask: URLSessionDataTask?
    var presenter: HomeInteractorToPresenterProtocol?
    
    func searchWeather(searchTerm :String ) {
        dataTask?.cancel()
        let queryString = String(format: "search.ashx?query=%@&num_of_results=3&format=json&key=%@",searchTerm,Constants.APIKEY )
        let url = URLGenerator.sharedInstance.urlWithType(type: .URLTYPESEARCH, parameters: queryString)
            dataTask =
                defaultSession.dataTask(with: url) { [weak self] data, response, error in
                    defer {
                        self?.dataTask = nil
                    }
                    if let error = error {
                        print(error)
                        self?.presenter?.weatherFetchFailed(message: error.localizedDescription)
                        
                    } else if
                        let data = data,
                        let response = response as? HTTPURLResponse,
                        response.statusCode == 200 {
                        print(response)
                        //self?.updateSearchResults(data)
                        DispatchQueue.main.async {
                        }
                    }
            }
            dataTask?.resume()
        
    }
}
