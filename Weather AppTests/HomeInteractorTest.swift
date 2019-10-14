//
//  HomeInteractorTest.swift
//  Weather AppTests
//
//  Created by User on 10/13/19.
//  Copyright © 2019 VK. All rights reserved.
//

import XCTest
@testable import Weather_App

class HomeInteractorTest: XCTestCase {
    
    class FakeHomeInteractionToPresenter: HomeInteractorToPresenterProtocol {
        func weatherFetchedSuccess(dateString: String) {
            XCTAssertNotNil(dateString)
        }
        
        func weatherFetchFailed(message: String) {
            XCTAssertNotNil(message)
        }
        
        func weatherDataResult(data: [SearchResult]?) {
            XCTAssertNotNil(data)
            for tempdata in data ?? [] {
                XCTAssertEqual(tempdata.createdDate , "2019-10-13'T'13:10:10.011")
                CoreDataHandler.sharedInstance.deleteObject(object: tempdata)
            }
        }
    }
    
    var presenter:HomeInteractorToPresenterProtocol?
    var interactor:HomeInteractor?
    override func setUp() {
        presenter = FakeHomeInteractionToPresenter()
        interactor = HomeInteractor()
        interactor?.presenter = presenter
    }
    
    override func tearDown() {
         interactor?.getWeatherData(by: "2019-10-13'T'13:10:10.011")
    }
    
    //MARK:- Test Get Weather Data
    func testGetWeatherData() {
        interactor?.getWeatherData(by: "2019-10-13'T'13:10:10.011")
    }
    
    //MARK:- Test Update Is View Status
    func testUpdateIsViewStatus() {
        let searchData:SearchResult = CoreDataHandler.sharedInstance.newEntityForName(entityName: "SearchResult") as! SearchResult
        interactor?.updateIsViewStatus(for: searchData)
        XCTAssertEqual(searchData.isViewed, true)
        XCTAssert(searchData.isViewed)
        
    }
    
    //MARK:- Test Search Weather
    func testSearchWeather() {
        interactor?.searchWeather(searchTerm: "Singapore")
    }
    //MARK:- Test Process Weather Result
    func testProcessWeatherResult() {
        interactor?.processWeatherResult(resultData: Data(base64Encoded: "test")!, currentDate: "2019-10-13'T'13:10:10.011")
        interactor?.getWeatherData(by: "2019-10-13'T'13:10:10.011")
    }
    //MARK:- Test Save Search Result
    func testSaveSearchResult() {
        var data:[String:AnyObject] = [:]
        data["latitude"] = "12345" as AnyObject
        let searchResult = interactor?.saveSearchResult(searchResult: data, date: "2019-10-13'T'13:10:10.011")
        XCTAssertNotNil(searchResult)
    }
    //MARK:- Test Check Search ResultExist
    func testCheckSearchResultExist() {
        let result = interactor?.checkSearchResultExist(area: "test", country: "testCountry", region: "testRegion")
        XCTAssertNil(result)
    }
    
    
}
