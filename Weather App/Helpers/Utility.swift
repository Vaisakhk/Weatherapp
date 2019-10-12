//
//  Utility.swift
//  Weather App
//
//  Created by User on 10/12/19.
//  Copyright © 2019 VK. All rights reserved.
//

import UIKit

class Utility: NSObject {

    public static let sharedInstance = Utility()
    //MARK:- Get child value
    func getChildValue(dataValue:[[String:AnyObject]]?) ->String {
        var resultString = ""
        if let tempData = dataValue {
            for data in tempData {
                if let tempString = data["value"] as? String {
                    resultString = tempString
                }
            }
        }
        return resultString
    }
    

}
