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
    
    //MARK :- Get current weather Data
    func getCurrentWeatherData(by cityName: String) {
        dataTask?.cancel()
        let queryString = String(format: "weather.ashx?&q=%@&num_of_days=1&tp=1&format=json&key=%@",cityName,Constants.APIKEY )
        let url = URLGenerator.sharedInstance.urlWithType(type: .URLTYPESEARCH, parameters: queryString)
            dataTask =
                defaultSession.dataTask(with: url) { [weak self] data, response, error in
                    defer {
                        self?.dataTask = nil
                    }
                    if let error = error {
                        print(error)
                        DispatchQueue.main.async {
                            self?.presenter?.weatherFetchFailed(message: error.localizedDescription)
                        }
                    }else if
                        let data = data,
                        let response = response as? HTTPURLResponse,
                        response.statusCode == 200 {
                        self?.processWeatherResult(resultData: data)
                        DispatchQueue.main.async {
//                            self?.presenter?.weatherFetchedSuccess(dateString: date)
                        }
                    }
            }
            dataTask?.resume()
    }
    
        //MARK:- Process the weather result
     func processWeatherResult(resultData:Data) {
        do {
            if let result:[String:[String:[[String:AnyObject]]]] =  try JSONSerialization.jsonObject(with: resultData, options: JSONSerialization.ReadingOptions.allowFragments) as? [String:[String:[[String:AnyObject]]]] {
                if let data =  result["data"]?["current_condition"] {
                    for dataResult in data {
                        let weatherIconUrl:String? =  Utility.sharedInstance.getChildValue(dataValue: dataResult["weatherIconUrl"] as? [[String : AnyObject]])
                        let weatherDesc:String? = Utility.sharedInstance.getChildValue(dataValue: dataResult["weatherDesc"] as? [[String : AnyObject]])
                        let humidity:String? =  dataResult["humidity"] as? String
                        let temperature:String? =   dataResult["temp_C"] as? String
                        let observationTime:String? =   dataResult["observation_time"] as? String
                        let weatherResult = WeatherResult(humidity: humidity ?? "",imageUrl: weatherIconUrl ?? "",weatherDescription: weatherDesc ?? "",temperature: temperature ?? "",observationTime: observationTime ?? "")
                        downloadImage(urlString: weatherResult.imageUrl)
                        DispatchQueue.main.async { [weak self] in
                            self?.presenter?.weatherFetchedSuccess(weatherReport:weatherResult)
                            
                        }
                    }
                }
            }
        }catch{
            
        }
    }
    
    func getData(from url: URL, completion: @escaping (Data?, URLResponse?, Error?) -> ()) {
        URLSession.shared.dataTask(with: url, completionHandler: completion).resume()
    }
    
    func downloadImage(urlString :String) {
        if let url = URL(string: urlString) {
            getData(from: url) { data, response, error in
                guard let data = data, error == nil else { return }
                DispatchQueue.main.async() {
                    self.presenter?.weatherImageDownloaded(data:data)
                }
            }
        }
    }
}
