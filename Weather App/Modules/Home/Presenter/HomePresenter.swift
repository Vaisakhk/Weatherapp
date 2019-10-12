//
//  HomePresenter.swift
//  Weather App
//
//  Created by User on 10/12/19.
//  Copyright © 2019 VK. All rights reserved.
//

import UIKit

class HomePresenter: HomeViewToPresenterProtocol {
    var view: HomePresenterToViewProtocol?
    
    var interactor: HomePresenterToInteractorProtocol?
    
    var router: HomePresenterToRouterProtocol?
    
    func startSearchingData(searchString:String) {
        interactor?.searchWeather(searchTerm: searchString)
    }
    
    func showDetailController(navigationController: UINavigationController) {
        
    }
    
    func updateViewStatus(for data :SearchResult) {
        interactor?.updateIsViewStatus(for: data)
    }

    func getRecentSearchResult() {
        interactor?.getRecentWeatherData()
    }
}

extension HomePresenter : HomeInteractorToPresenterProtocol {
    func weatherDataResult(data: [SearchResult]?) {
        view?.showSearchResult(searchArray: data ?? [])
    }
    
    func weatherFetchedSuccess(dateString: String) {
        interactor?.getWeatherData(by: dateString)
    }
    
    func weatherFetchFailed(message:String) {
        view?.showError(message: message)
    }
    
}
