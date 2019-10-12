//
//  ViewController.swift
//  Weather App
//
//  Created by User on 10/12/19.
//  Copyright © 2019 VK. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

     var presentor:HomePresenterToViewProtocol?
    
    override func viewDidLoad() {
        super.viewDidLoad()
     
    }
}

extension ViewController : HomePresenterToViewProtocol {
    func showSearchResult(searchArray: Array<NSObject>) {
        
    }
    
    func showError() {
        
    }
    
    
}

