//
//  HomeProtocol.swift
//  Weather App
//
//  Created by User on 10/12/19.
//  Copyright © 2019 VK. All rights reserved.
//

import UIKit

protocol HomeViewToPresenterProtocol: class{
    
    var view: HomePresenterToViewProtocol? {get set}
    var interactor: HomePresenterToInteractorProtocol? {get set}
    var router: HomePresenterToRouterProtocol? {get set}
    func startSearchingData(searchString :String)
    func updateViewStatus(for data :SearchResult)
    func getRecentSearchResult()
    func showDetailScreen(with searchData:SearchResult)
}

protocol HomePresenterToViewProtocol: class{
    func showSearchResult(searchArray:[SearchResult])
    func showError(message:String)
    func showWeatherDetailScreen(detailView:DetailViewController)
}

protocol HomePresenterToRouterProtocol: class {
    static func createModule()-> UINavigationController
    func pushToDetailScreen(searchData:SearchResult)-> DetailViewController
}

protocol HomePresenterToInteractorProtocol: class {
    var presenter:HomeInteractorToPresenterProtocol? {get set}
    func searchWeather(searchTerm :String)
    func getWeatherData(by date:String)
    func updateIsViewStatus(for weatherData :SearchResult)
    func getRecentWeatherData()
}

protocol HomeInteractorToPresenterProtocol: class {
    func weatherFetchedSuccess(dateString:String)
    func weatherFetchFailed(message:String)
    func weatherDataResult(data:[SearchResult]?)
}
