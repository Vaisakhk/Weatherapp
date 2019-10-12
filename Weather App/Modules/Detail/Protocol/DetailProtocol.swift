//
//  DetailProtocol.swift
//  Weather App
//
//  Created by User on 10/13/19.
//  Copyright © 2019 VK. All rights reserved.
//

import UIKit


protocol DetailViewToPresenterProtocol: class{
    
    var view: DetailPresenterToViewProtocol? {get set}
    var interactor: DetailPresenterToInteractorProtocol? {get set}
    var router: DetailPresenterToRouterProtocol? {get set}
    func getWeatherReportData(by city :String)
}

protocol DetailPresenterToViewProtocol: class{
    func showWeatherResult(weather:WeatherResult)
    func showError(message:String)
}

protocol DetailPresenterToRouterProtocol: class {
    static func createDetailModule(currentData:SearchResult) -> DetailViewController
}

protocol DetailPresenterToInteractorProtocol: class {
    var presenter:DetailInteractorToPresenterProtocol? {get set}
    func getCurrentWeatherData(by cityName:String)

}

protocol DetailInteractorToPresenterProtocol: class {
    func weatherFetchedSuccess(weatherReport:WeatherResult)
    func weatherFetchFailed(message:String)
}
