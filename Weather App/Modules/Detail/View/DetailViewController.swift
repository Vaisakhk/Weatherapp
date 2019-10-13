//
//  DetailViewController.swift
//  Weather App
//
//  Created by User on 10/13/19.
//  Copyright © 2019 VK. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {

    @IBOutlet weak var weatherLabel: UILabel!
    @IBOutlet weak var humidityLabel: UILabel!
    @IBOutlet weak var temperatureLabel: UILabel!
    @IBOutlet weak var weatherImageView: UIImageView!
    @IBOutlet weak var progressAnimationView: UIView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    var searchResult:SearchResult?
    var presenter:DetailViewToPresenterProtocol?
    
    //MARK:- UIView Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()

        presenter?.getWeatherReportData(by: searchResult?.areaName ?? "")
    }

    func showProgressView() {
           progressAnimationView.isHidden = false
           activityIndicator.startAnimating()
       }
       
       func hideProgressView() {
           activityIndicator.stopAnimating()
           progressAnimationView.isHidden = true
       }
}

//MARK:- Call back Delegates from Presenter
extension DetailViewController : DetailPresenterToViewProtocol {
    func showWeatherResult(weather: WeatherResult) {
        print(weather.weatherDescription)
        weatherLabel.text = weather.weatherDescription
        temperatureLabel.text = weather.temperature
        humidityLabel.text = weather.humidity
        hideProgressView()
    }

    func showError(message: String) {
        CLAlertHandler.sharedHandlerInsatnce.showAlert(alertMessage: message, title: Constants.appName, contoller: self) { (isSuccess) in
            self.navigationController?.popViewController(animated: true)
        }
         hideProgressView()
    }
    
    func displayImage(imageData: Data) {
        weatherImageView.image = UIImage(data: imageData)
    }
}
