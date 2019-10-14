//
//  DetailIneractorTest.swift
//  Weather AppTests
//
//  Created by User on 10/14/19.
//  Copyright © 2019 VK. All rights reserved.
//

import XCTest
@testable import Weather_App

class DetailIneractorTest: XCTestCase {
    
    
    class FakeHomeInteractionToPresenter: DetailInteractorToPresenterProtocol {
        func weatherFetchedSuccess(weatherReport: WeatherResult) {
            XCTAssertNotNil(weatherReport)
        }
        func weatherFetchFailed(message: String) {
            XCTAssertNotNil(message)
        }
        func weatherImageDownloaded(data: Data) {
            XCTAssertNotNil(data)
        }
    }
    
    var presenter:DetailInteractorToPresenterProtocol?
    var interactor:DetailInteractor?
    
    override func setUp() {
        presenter = FakeHomeInteractionToPresenter()
        interactor = DetailInteractor()
        interactor?.presenter = presenter
    }
    
    override func tearDown() {
        
    }
    
    //MARK:- Test Get Current WeatherData
    func testGetCurrentWeatherData() {
        interactor?.getCurrentWeatherData(by: "2019-10-13'T'13:10:10.011")
    }
    
    //MARK:- Test Process Weather Result
    func testProcessWeatherResult() {
        interactor?.processWeatherResult(resultData: Data(base64Encoded: "test")!)
    }
    //MARK:- Test Download Image
    func testDownloadImage() {
        interactor?.downloadImage(urlString: "http://cdn.worldweatheronline.net/images/wsymbols01_png_64/wsymbol_0004_black_low_cloud.png")
    }
}
