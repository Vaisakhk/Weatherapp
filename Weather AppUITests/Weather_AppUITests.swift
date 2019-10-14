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
    
    func testUI() {
        
        app.launch()
        //        XCTAssertEqual(app.staticTexts.value as! String, "Please wait featching the result....")
    }
    
//    func testLaunchPerformance() {
//        if #available(macOS 10.15, iOS 13.0, tvOS 13.0, *) {
//            // This measures how long it takes to launch your application.
//            measure(metrics: [XCTOSSignpostMetric.applicationLaunch]) {
//                XCUIApplication().launch()
//            }
//        }
//    }
}
