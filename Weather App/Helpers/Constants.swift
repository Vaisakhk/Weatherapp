//
//  Constants.swift
//  Weather App
//
//  Created by User on 10/12/19.
//  Copyright © 2019 VK. All rights reserved.
//

import UIKit

struct Constants {
    static let appName = Bundle.main.infoDictionary![kCFBundleNameKey as String] as! String
    
    static let BASEURL =  "http://api.worldweatheronline.com/premium/v1/"
    static let APIKEY =  "2b4d0bc9a6b6446897c85954191110"
}
