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
    
    func startSearchingData() {
        
    }
    
    func showDetailController(navigationController: UINavigationController) {
        
    }
    

}

extension HomePresenter : HomeInteractorToPresenterProtocol {
    func weatherFetchedSuccess(searchModelArray: Array<NSObject>) {
        
    }
    
    func weatherFetchFailed() {
        
    }
    
}
