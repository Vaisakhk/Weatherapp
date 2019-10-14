//
//  HomeRouterTest.swift
//  Weather AppTests
//
//  Created by User on 10/14/19.
//  Copyright © 2019 VK. All rights reserved.
//

import XCTest
@testable import Weather_App

class HomeRouterTest: XCTestCase {
    var homeRouter: HomeRouter!
    override func setUp() {
        homeRouter = HomeRouter()
    }

    override func tearDown() {
    }
    
    //MARK:- Test Create Detail Module
    func testCreateModule() {
        let controller =  HomeRouter.createModule()
        XCTAssertTrue(controller.isKind(of: UINavigationController.self))
    }
    
    //MARK:- Test PUSH to detail screen
    func testPushToDetailScreen() {
        let searchData:SearchResult = CoreDataHandler.sharedInstance.newEntityForName(entityName: "SearchResult") as! SearchResult
        let controller =  homeRouter.pushToDetailScreen(searchData: searchData)
        XCTAssertTrue(controller.isKind(of: DetailViewController.self))
    }
    
}
