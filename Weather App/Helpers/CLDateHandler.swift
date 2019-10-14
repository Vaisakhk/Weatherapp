//
//  CLDateHandler.swift
//  VK
//
//  Created by Apple on 31/05/17.
//  Copyright © 2017 VK. All rights reserved.
//

import UIKit

public class CLDateHandler: NSObject {
    
    @objc public static let sharedHandlerInsatnce = CLDateHandler()
    let dateFormatter:DateFormatter = DateFormatter ()
    
    /**
     *  Convert NSDate to string format
     *
     *  @param currentDate : date that we need to convert
     *       formatedString: string format that we need to convert current date (EX: YYYY-mm-dd hh:MM:ss sss)
     *
     *  @return            : Converted String
     *
     */
    
   @objc public func convertDateToFormatedString(currentDate:Date,formatedString:String,timezone:TimeZone) ->String {
        dateFormatter.timeZone = timezone
        dateFormatter.dateFormat = formatedString
        return dateFormatter.string(from: currentDate)
    }
    
    /**
     *  Convert string to NSDate format
     *
     *  @param dateString  : String that we need to convert
     *       formatedString: string format that we need to convert current date (EX: YYYY-mm-dd hh:MM:ss sss)
     *              timezon: Date Time zone
     *  @return            : Converted Date
     *
     */

    
   @objc public func convertToDateCorespondingTo(dateString:String,formatedString:String,timezone:TimeZone) -> Date? {
        dateFormatter.timeZone = timezone
        dateFormatter.dateFormat = formatedString
        return dateFormatter.date(from: dateString)
    }
    
}
