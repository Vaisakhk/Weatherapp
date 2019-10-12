//
//  DetailPresenter.swift
//  Weather App
//
//  Created by User on 10/13/19.
//  Copyright © 2019 VK. All rights reserved.
//

import UIKit

class DetailPresenter: DetailViewToPresenterProtocol {
    
    var view: DetailPresenterToViewProtocol?
    var interactor: DetailPresenterToInteractorProtocol?
    var router: DetailPresenterToRouterProtocol?
    
    func getWeatherReportData(by city: String) {
        interactor?.getCurrentWeatherData(by: city)
    }
}

extension DetailPresenter : DetailInteractorToPresenterProtocol {
    func weatherFetchedSuccess(weatherReport: WeatherResult) {
        view?.showWeatherResult(weather: weatherReport)
    }
    
    func weatherFetchFailed(message: String) {
        view?.showError(message: message)
    }
    

}
