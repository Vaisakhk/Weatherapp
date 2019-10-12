//
//  DetailRouter.swift
//  Weather App
//
//  Created by User on 10/13/19.
//  Copyright © 2019 VK. All rights reserved.
//

import UIKit

class DetailRouter: DetailPresenterToRouterProtocol {

    static func createDetailModule(currentData:SearchResult) -> DetailViewController {
           let view = mainstoryboard.instantiateViewController(withIdentifier: "detailViewController") as! DetailViewController
           
           let presenter: DetailViewToPresenterProtocol & DetailInteractorToPresenterProtocol = DetailPresenter()
           let interactor: DetailPresenterToInteractorProtocol = DetailInteractor()
           let router:DetailPresenterToRouterProtocol = DetailRouter()
           
           view.presenter = presenter
           view.searchResult = currentData
           presenter.view = view as DetailPresenterToViewProtocol
           presenter.router = router
           presenter.interactor = interactor
           interactor.presenter = presenter
           return view
       }
       
       static var mainstoryboard: UIStoryboard{
           return UIStoryboard(name:"Main",bundle: Bundle.main)
       }
       
}
