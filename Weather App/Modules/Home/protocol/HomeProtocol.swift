//
//  HomeProtocol.swift
//  Weather App
//
//  Created by User on 10/12/19.
//  Copyright © 2019 VK. All rights reserved.
//

import UIKit

class HomeProtocol: NSObject {

}

protocol HomeViewToPresenterProtocol: class{
    
    var view: HomePresenterToViewProtocol? {get set}
    var interactor: HomePresenterToInteractorProtocol? {get set}
    var router: HomePresenterToRouterProtocol? {get set}
    func startSearchingData(searchString :String)
    func showDetailController(navigationController:UINavigationController)

}

protocol HomePresenterToViewProtocol: class{
    func showSearchResult(searchArray:Array<NSObject>)
    func showError()
}

protocol HomePresenterToRouterProtocol: class {
    static func createModule()-> ViewController
    func pushToDetailScreen(navigationConroller:UINavigationController)
}

protocol HomePresenterToInteractorProtocol: class {
    var presenter:HomeInteractorToPresenterProtocol? {get set}
    func searchWeather(searchTerm :String)
}

protocol HomeInteractorToPresenterProtocol: class {
    func weatherFetchedSuccess(searchModelArray:Array<NSObject>)
    func weatherFetchFailed(message:String)
}
