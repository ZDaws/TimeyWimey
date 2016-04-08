//
//  Runner Class.swift
//  Passing Test
//
//  Created by CHERMAK, ZACHARY on 12/16/15.
//  Copyright © 2015 CHERMAK, ZACHARY. All rights reserved.
//

import Foundation
import UIKit

class Runner: NSObject, NSCoding {
    //Instance Variables 
    var name: String
    var endTime: String
    var lapArray: [String] = []
    var laps: [String] = []
    
    struct PropertyKey {
        static let runnerNameKey = "runnerNameKey"
        static let endTimeKey = "endTimeKey"
        static let lapArrayKey = "lapArrayKey"
        static let lapsKey = "lapsKey"
    }
    
    //This is the function that I use to change the strings that we get from the stopwatch to change them into NSDates
    func toDate(time: String) -> NSDate{
        let DateFormatter = NSDateFormatter()
        DateFormatter.locale = NSLocale(localeIdentifier: "en_US_POSIX")
        DateFormatter.timeZone = NSTimeZone (name: "Central")
        DateFormatter.dateFormat = "mm:ss:SS"
        return DateFormatter.dateFromString(time)!
    }
    
    func toString(date: NSDate) -> String{
        let DateFormatter = NSDateFormatter()
        DateFormatter.locale = NSLocale(localeIdentifier: "en_US_POSIX")
        DateFormatter.timeZone = NSTimeZone (name: "Central")
        DateFormatter.dateFormat = "mm:ss:SS"
        return DateFormatter.stringFromDate(date)
    }
    
    
    init(n: String, endTime: String, lapArray: [String], laps: [String]) {
        name = n
        self.endTime = "00:00:00"
    }
    
    //MARK: NSCoding
    func encodeWithCoder(aCoder: NSCoder) {
        aCoder.encodeObject(name, forKey: PropertyKey.runnerNameKey)
        aCoder.encodeObject(endTime, forKey: PropertyKey.endTimeKey)
        aCoder.encodeObject(lapArray, forKey: PropertyKey.lapArrayKey)
        aCoder.encodeObject(laps, forKey: PropertyKey.lapsKey)
        print("runner encoding works")
    }
    
    required convenience init?(coder aDecoder: NSCoder){
        let name = aDecoder.decodeObjectForKey(PropertyKey.runnerNameKey) as! String
        let endTime = aDecoder.decodeObjectForKey(PropertyKey.endTimeKey) as! String
        let lapArray = aDecoder.decodeObjectForKey(PropertyKey.lapArrayKey) as! [String]
        let laps = aDecoder.decodeObjectForKey(PropertyKey.lapsKey) as! [String]
        
        self.init(n: name, endTime: endTime, lapArray: lapArray, laps: laps)
    }

    
    
    
    
    
    //INTRUCTIONS
    //changes each lap from a time stamp to its proper duration for that lap
    //to reference this modified array it will be in its normal array format just with the new values in their appropriate indexes
    
    //-to do the math u will need to change the lap of strings into dates to do the arithmatic and make sure to change them back to strings once you've finished
    
    //-test to see how many laps are in the array
    //if more than one entry in lapArray then take each value and subtract it by the previous to get the difference in duration
    //remember that the last lap in the array will need to use the final end time in order to find its duration
    
    
    
    
    
    
    func lapDur() {
        //necessary variables for the NSDate and NSDateComponents arithmetic
        let userCalendar = NSCalendar.currentCalendar()
        let minCalendarUnit: NSCalendarUnit = [.Minute, .Second, .Nanosecond]
        
        laps = lapArray
        
        //loop to go through the array to allow us to do arithmetic with it
        for var i = 0 ; i < lapArray.count; i++ {
            
            //for the indexes in the array that will do the subractions with other elements of the array
            if i < lapArray.count && i > 0 {
                let newTime = toDate(lapArray[i - 1])
                let lastTime = toDate(lapArray[i])
                
                //this does the arithmetic to find the time in minutes followed by seconds between the two variables and
                //adjusting for sign difference to keep it positive even with the backwards order
                let lap = userCalendar.components(minCalendarUnit, fromDate: newTime, toDate: lastTime, options: [])
                let finalDate = userCalendar.dateFromComponents(lap)
                
                laps[i] = toString(finalDate!)
            }
                //does the subtraction for the last index and the final end time to get the last indexes difference in time
            if i == lapArray.count - 1 {
                let lastTime = toDate(lapArray[i])
                let finalTime = toDate(endTime)
                let lap = userCalendar.components(minCalendarUnit, fromDate: lastTime, toDate: finalTime, options: [])
                let finalDate = userCalendar.dateFromComponents(lap)
                laps.append(toString(finalDate!))
            }
            
        }
        
        
        
    }
    
    
    
    
    
    //Csv headings
    //Name, End Time, Lap
    
    //if race only has one lap so only an endtime dont record or export any laps, if it has multiple subtract and determine
    //each individual lap's duration
}
