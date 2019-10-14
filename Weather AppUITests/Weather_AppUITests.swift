//
//  Weather_AppUITests.swift
//  Weather AppUITests
//
//  Created by User on 10/12/19.
//  Copyright © 2019 VK. All rights reserved.
//

import XCTest

class Weather_AppUITests: XCTestCase {
    var app: XCUIApplication!
    override func setUp() {
        super.setUp()
        continueAfterFailure = false
        app = XCUIApplication()
    }
    
    override func tearDown() {
    }
    
    func testWeatherUI() {
        app.launch()
//        let isDisplayingOnboarding = app.otherElements["ProgressView"].exists
//        XCTAssertTrue(isDisplayingOnboarding)
//        XCTAssertEqual(app.staticTexts.element(boundBy: 0).value as! String, "Please wait featching the result....")
        app.swipeLeft()
    }
    
}
