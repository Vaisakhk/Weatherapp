//
//  Weather_AppTests.swift
//  Weather AppTests
//
//  Created by User on 10/12/19.
//  Copyright © 2019 VK. All rights reserved.
//

import XCTest
@testable import Weather_App

class Weather_AppTests: XCTestCase {

    override func setUp() {
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testUtilityChildValue() {
        XCTAssertNotNil(Utility.sharedInstance.getChildValue(dataValue: nil))
        XCTAssertEqual(Utility.sharedInstance.getChildValue(dataValue: nil)  , "")
        let data:[[String : String]] = [["value":"Test Value"]]
        XCTAssertEqual(Utility.sharedInstance.getChildValue(dataValue: data as [[String : AnyObject]])  , "Test Value")
    }
    
    func testCLDateHandler() {
        let currentDate = Date()
        
        let dateString = CLDateHandler.sharedHandlerInsatnce.convertDateToFormatedString(currentDate: currentDate, formatedString: Constants.TIMEFORMAT, timezone: TimeZone.current)
        let date = CLDateHandler.sharedHandlerInsatnce.convertToDateCorespondingTo(dateString: dateString, formatedString: Constants.TIMEFORMAT, timezone: TimeZone.current)
        
        let tempString = CLDateHandler.sharedHandlerInsatnce.convertDateToFormatedString(currentDate: date!, formatedString: Constants.TIMEFORMAT, timezone: TimeZone.current)
        XCTAssertEqual(tempString, dateString)
    }

}
