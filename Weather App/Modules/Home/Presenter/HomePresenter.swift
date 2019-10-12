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
    

}

extension HomePresenter : HomeInteractorToPresenterProtocol {
    func weatherFetchedSuccess(dateString: String) {
        let predicate = NSPredicate(format: "createdDate == %@",dateString)
         view?.showSearchResult(searchArray: CoreDataHandler.sharedInstance.getAllDatasWithPredicate(entity: "SearchResult", predicate: predicate, sortDescriptor: NSSortDescriptor(key: "createdDate", ascending: true)) as! [SearchResult])
    }

    
    func weatherFetchFailed(message:String) {
        view?.showError(message: message)
    }
    
}
