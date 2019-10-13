//
//  ViewController.swift
//  Weather App
//
//  Created by User on 10/12/19.
//  Copyright © 2019 VK. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var progressView: UIView!
    @IBOutlet weak var noDataLabel: UILabel!
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    var presenter:HomeViewToPresenterProtocol?
    lazy var dataArray : [SearchResult] = {
        return []
    }()
    
    //MARK:- UIView LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.register(UINib(nibName: "HomeTableViewCell", bundle: nil), forCellReuseIdentifier: "Cell")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        if(searchBar.text?.count == 0) {
            populateData()
        }
    }
    
    //MARK:- Populate data
    func populateData() {
        dataArray.removeAll()
        presenter?.getRecentSearchResult()
        tableView.reloadData()
    }
    
    //MARK:- Handle view Visibility
    func handleViewVisibility(isHideTableView:Bool) {
        noDataLabel.isHidden = !isHideTableView
        tableView.isHidden = isHideTableView
    }
    
    func showProgressView() {
        progressView.isHidden = false
        activityIndicator.startAnimating()
    }
    
    func hideProgressView() {
        activityIndicator.stopAnimating()
        progressView.isHidden = true
    }
}

//MARK:- Call back Delegates from Presenter
extension ViewController : HomePresenterToViewProtocol {
    func showWeatherDetailScreen(detailView: DetailViewController) {
         self.navigationController?.pushViewController(detailView, animated: true)
    }
    
    func showSearchResult(searchArray: [SearchResult]) {
        if(searchArray.count != 0) {
            handleViewVisibility(isHideTableView: false)
        }else {
            handleViewVisibility(isHideTableView: true)
        }
        dataArray = searchArray
        tableView.reloadData()
        hideProgressView()
    }
    
    func showError(message:String) {
        hideProgressView()
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
        return homeCell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        presenter?.updateViewStatus(for: self.dataArray[indexPath.row])
        presenter?.showDetailScreen(with: self.dataArray[indexPath.row])
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        self.view.endEditing(true)
    }
    
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        if(searchBar.text?.count == 0) {
            populateData()
        }
    }
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        self.view.endEditing(true)
        if(searchBar.text?.count == 0) {
            populateData()
        }else {
            showProgressView()
            presenter?.startSearchingData(searchString: searchBar.text ?? "")
        }
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if(searchBar.text?.count == 0) {
            populateData()
            self.view.endEditing(true)
        }else {
            
        }
    }
}
