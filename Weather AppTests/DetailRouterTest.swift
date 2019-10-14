//
//  DetailRouterTest.swift
//  Weather AppTests
//
//  Created by User on 10/14/19.
//  Copyright © 2019 VK. All rights reserved.
//

import XCTest
@testable import Weather_App

class DetailRouterTest: XCTestCase {

    
    override func setUp() {
    }

    override func tearDown() {

    }
    
    //MARK:- Test Create Detail Module
    func testCreateDetailModule() {
        let searchData:SearchResult = CoreDataHandler.sharedInstance.newEntityForName(entityName: "SearchResult") as! SearchResult
        let controller =  DetailRouter.createDetailModule(currentData:searchData)
        XCTAssertTrue(controller.isKind(of: DetailViewController.self))
    }
}
