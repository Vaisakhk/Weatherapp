//
//  HomeRouter.swift
//  Weather App
//
//  Created by User on 10/12/19.
//  Copyright © 2019 VK. All rights reserved.
//

import UIKit

class HomeRouter: HomePresenterToRouterProtocol {
    func pushToDetailScreen(searchData: SearchResult) -> DetailViewController {
        return DetailRouter.createDetailModule(currentData: searchData)
    }
    

    static func createModule() -> UINavigationController {
        let view = mainstoryboard.instantiateViewController(withIdentifier: "ViewController") as! ViewController
        
        let presenter: HomeViewToPresenterProtocol & HomeInteractorToPresenterProtocol = HomePresenter()
        let interactor: HomePresenterToInteractorProtocol = HomeInteractor()
        let router:HomePresenterToRouterProtocol = HomeRouter()
        
        view.presenter = presenter
        presenter.view = view as HomePresenterToViewProtocol
        presenter.router = router
        presenter.interactor = interactor
        interactor.presenter = presenter
        return UINavigationController(rootViewController: view)
    }
    
    static var mainstoryboard: UIStoryboard{
        return UIStoryboard(name:"Main",bundle: Bundle.main)
    }
    
}
