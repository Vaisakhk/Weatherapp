//
//  HomePresenterTest.swift
//  Weather AppTests
//
//  Created by User on 10/14/19.
//  Copyright © 2019 VK. All rights reserved.
//

import XCTest
@testable import Weather_App

class HomePresenterTest: XCTestCase {
    
    class FakeInteractor:HomePresenterToInteractorProtocol {
        var presenter: HomeInteractorToPresenterProtocol?
        
        func searchWeather(searchTerm: String) {
             XCTAssertNotNil(searchTerm)
             XCTAssertEqual(searchTerm, "Singapore")
            presenter?.weatherFetchedSuccess(dateString: "2019-10-13'T'13:10:10.011")
        }
        
        func getWeatherData(by date: String) {
             XCTAssertNotNil(date)
             presenter?.weatherDataResult(data: [])
        }
        
        func updateIsViewStatus(for weatherData: SearchResult) {
             XCTAssertNotNil(weatherData)
             XCTAssertEqual(weatherData.isViewed, false)
        }
        
        func getRecentWeatherData() {
             presenter?.weatherDataResult(data: [])
        }
        
    }
    
    var homePresenter: HomePresenter!
    //MARK:- Test Create Detail Module
    override func setUp() {
        homePresenter = HomePresenter()
        homePresenter.interactor = FakeInteractor()
    }
    
    override func tearDown() {
        
    }
    
    //MARK:- Test Start Searching Data
    func testStartSearchingData () {
        homePresenter.startSearchingData(searchString: "Singapore")
    }
    //MARK:- Test Update View Status
    func testUpdateViewStatus(for data :SearchResult) {
        let searchData:SearchResult = CoreDataHandler.sharedInstance.newEntityForName(entityName: "SearchResult") as! SearchResult
        searchData.isViewed = false
        homePresenter.updateViewStatus(for: searchData)
        XCTAssertEqual(searchData.isViewed, true)
               XCTAssert(searchData.isViewed)
    }
    //MARK:- Test Get Recent Search Result
    func testGetRecentSearchResult() {
        homePresenter.getRecentSearchResult()
    }
    
    //MARK:- Test Show Detail Screen
    func testShowDetailScreen(with searchData:SearchResult) {
        let searchData:SearchResult = CoreDataHandler.sharedInstance.newEntityForName(entityName: "SearchResult") as! SearchResult
        homePresenter.showDetailScreen(with: searchData)
    }
    
    func testUpdateViewStatus () {
        let searchData:SearchResult = CoreDataHandler.sharedInstance.newEntityForName(entityName: "SearchResult") as! SearchResult
        homePresenter.updateViewStatus(for: searchData)
    }
    
    func testWeatherFetchFailed () {
        homePresenter.weatherFetchFailed(message: "")
    }
    
    func testWeatherFetchedSuccess() {
        homePresenter.weatherFetchedSuccess(dateString: "")
    }
}
