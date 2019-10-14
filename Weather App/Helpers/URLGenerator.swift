//
//  URLGenerator.swift
//  KLXIncident
//
//  Created by User on 4/22/18.
//  Copyright © 2018 VK. All rights reserved.
//

import UIKit


@objc class URLGenerator: NSObject {
    @objc public static let sharedInstance = URLGenerator()
    @objc enum URLTYPE:Int {
        case URLTYPESEARCH = 1
        case URLTYPEWEATHERDETAIL = 2
    }

    /**
     *  Get Service URL
     *
     *  @param type  : Type of servise we are calling
     *    parameters : Any additional URL encoded parameters
     *  @return           : URL created with requirment
     *
     */

    @objc func urlWithType(type:URLTYPE,parameters:String?)-> URL {
        var urlString:String = ""
        switch type {
        case .URLTYPESEARCH:
            urlString = Constants.BASEURL + (parameters ?? "")
            
        case .URLTYPEWEATHERDETAIL:
            urlString = Constants.BASEURL + (parameters ?? "")
        }
        return URL.init(string: urlString.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!)!
    }
    
}
