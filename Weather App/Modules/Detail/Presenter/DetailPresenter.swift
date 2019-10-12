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
        
    }
}

extension DetailPresenter : DetailInteractorToPresenterProtocol {
    func weatherFetchedSuccess(dateString: String) {
        
    }
    
    func weatherFetchFailed(message: String) {
        
    }
    
    func weatherDataResult(data: [SearchResult]?) {
        
    }
    

}
