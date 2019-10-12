//
//  DetailViewController.swift
//  Weather App
//
//  Created by User on 10/13/19.
//  Copyright © 2019 VK. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {

    var presenter:DetailViewToPresenterProtocol?
    
    //MARK:- UIView Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()

    }

}

//MARK:- Call back Delegates from Presenter
extension DetailViewController : DetailPresenterToViewProtocol {
    func showSearchResult(searchArray: [SearchResult]) {
        
    }
    
    func showError(message: String) {
        
    }
    
}
