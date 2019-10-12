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
    
    var searchResult:SearchResult?
    var presenter:DetailViewToPresenterProtocol?
    
    //MARK:- UIView Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()

        presenter?.getWeatherReportData(by: searchResult?.areaName ?? "")
    }

}

//MARK:- Call back Delegates from Presenter
extension DetailViewController : DetailPresenterToViewProtocol {
    func showWeatherResult(weather: WeatherResult) {
        print(weather.weatherDescription)
        weatherLabel.text = weather.weatherDescription
        temperatureLabel.text = weather.temperature
        humidityLabel.text = weather.humidity
        do {
            if let url = URL(string: weather.imageUrl) {
                let imageData = try Data(contentsOf: url)
                    weatherImageView.image = UIImage(data:imageData)
            }
        }catch{
            
        }
    }

    
    func showError(message: String) {
        
    }
    
}
