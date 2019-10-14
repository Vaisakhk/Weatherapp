//
//  DetailPresenterTest.swift
//  Weather AppTests
//
//  Created by User on 10/14/19.
//  Copyright © 2019 VK. All rights reserved.
//

import XCTest
@testable import Weather_App

class DetailPresenterTest: XCTestCase {

    class FakeDetailInteractionToPresenter: DetailPresenterToInteractorProtocol {
        var presenter: DetailInteractorToPresenterProtocol?
        
        func getCurrentWeatherData(by cityName: String) {
            XCTAssertNotNil(cityName)
            XCTAssertEqual(cityName, "Singapore")
        }
    }
    
    class FakeDetailPresenterToViewProtocol :DetailPresenterToViewProtocol {
        func showWeatherResult(weather: WeatherResult) {
            XCTAssertNotNil(weather)
        }
        
        func showError(message: String) {
            XCTAssertNotNil(message)
        }
        
        func displayImage(imageData: Data) {
            XCTAssertNotNil(imageData)
        }
        
        
    }
    
    var detailPresenter: DetailPresenter!
    
    override func setUp() {
        detailPresenter = DetailPresenter()
        detailPresenter.interactor = FakeDetailInteractionToPresenter()
        detailPresenter.view = FakeDetailPresenterToViewProtocol()
    }

    override func tearDown() {
    }
    
    //MARK:- Get weather Data
    func testgetWeatherReportData() {
        detailPresenter.getWeatherReportData(by: "Singapore")
    }
    
    func testweatherImageDownloaded () {
         detailPresenter.weatherImageDownloaded(data: Data())
    }
    
    func testweatherFetchFailed() {
         detailPresenter.weatherFetchFailed(message: "")
    }
    
    func testweatherFetchedSuccess () {
         detailPresenter.weatherFetchedSuccess(weatherReport: WeatherResult())
    }
}
