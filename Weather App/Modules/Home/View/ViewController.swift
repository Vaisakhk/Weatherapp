//
//  ViewController.swift
//  Weather App
//
//  Created by User on 10/12/19.
//  Copyright © 2019 VK. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var noDataLabel: UILabel!
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var tableView: UITableView!
    var presenter:HomeViewToPresenterProtocol?
    lazy var dataArray : [SearchResult] = {
        return []
    }()
    
    //MARK:- UIView LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.register(UINib(nibName: "HomeTableViewCell", bundle: nil), forCellReuseIdentifier: "Cell")
    }
}

//MARK:- Call back Delegates from Presenter
extension ViewController : HomePresenterToViewProtocol {
    func showSearchResult(searchArray: [SearchResult]) {
        print(searchArray)
        if(searchArray.count != 0) {
            noDataLabel.isHidden = true
            tableView.isHidden = false
        }else {
            noDataLabel.isHidden = false
            tableView.isHidden = true
        }
        dataArray = searchArray
        tableView.reloadData()
    }
    
    func showError(message:String) {
        CLAlertHandler.sharedHandlerInsatnce.showAlert(alertMessage: message, title: Constants.appName, contoller: self) { (isSuccess) in
            
        }
    }
}

//MARK:- TableView and search bar Delegates
extension ViewController : UISearchBarDelegate,UITableViewDelegate,UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let homeCell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath as IndexPath) as! HomeTableViewCell
            homeCell.tag = indexPath.row + 1000
        homeCell.populateData(searchData: self.dataArray[indexPath.row] )
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        self.view.endEditing(true)
    }
    
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        if(searchBar.text?.count == 0) {
            
        }
    }
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        self.view.endEditing(true)
        if(searchBar.text?.count == 0) {
            
        }else {
            presenter?.startSearchingData(searchString: searchBar.text ?? "")
        }
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if(searchBar.text?.count == 0) {
            //populateData()
        }else {
            
        }
    }
}
