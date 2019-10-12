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
     *  To get time stamp from date
     *
     *  @param date : date that we need to convert
     *
     *  @return     : Time stamp
     *
     */

    
   @objc public func createTimeStampFor(date:Date) -> NSNumber {
        return NSNumber(value: date.timeIntervalSince1970)
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
    
    /**
     *  Compare two dates
     *
     *  @param fromDateTime : first Date
     *            toDateTime: Second Date
     *
     *  @return            : NSDateComponents object that gives all information about date difference
     *
     */
    
   @objc public func compareDates(fromDateTime:Date,toDateTime:Date) -> DateComponents {
        let calendar = Calendar.current
        return  calendar.dateComponents([.day,.month,.year,.hour,.minute,.second,.weekday,.weekdayOrdinal], from: fromDateTime, to: toDateTime)
    }
    
    /**
     *  Get date
     *
     *  @param fromDate : From Date
     *         unit     : Unit to be added
     *
     *  @return         : Date by adding unit to the from date
     *
     */
    public func getDate(from date:Date, byAdding unit:Int) -> Date {
        return Calendar.current.date(byAdding: .day, value: unit, to: date)!
    }
}
