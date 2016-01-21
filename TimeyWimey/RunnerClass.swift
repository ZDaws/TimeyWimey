//
//  Runner Class.swift
//  Passing Test
//
//  Created by CHERMAK, ZACHARY on 12/16/15.
//  Copyright © 2015 CHERMAK, ZACHARY. All rights reserved.
//

import Foundation


class Runner {
    //Instance Variables 
    var name: String
    var endTime: String
    var lapArray: [String]
    
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
    
    var csv = "" //Single string used to export into CSV file
    
    init(n: String, et: String, la: [String])  {
        name = n
        endTime = et
        lapArray = la
    }
    
    //INTRUCTIONS
    //changes each lap from a time stamp to its proper duration for that lap
    //to reference this modified array it will be in its normal array format just with the new values in their appropriate indexes
    
    //-to do the math u will need to change the lap of strings into dates to do the arithmatic and make sure to change them back to strings once you've finished
    
    //-test to see how many laps are in the array
        //if more than one entry in lapArray then take each value and subtract it by the previous to get the difference in duration
    //remember that the last lap in the array will need to use the final end time in order to find its duration
    
    func lapDur() {
        for var i = 0 ; i < lapArray.count - 1; i++ {
            if i == 0 {
                lapArray[i] = laps[i]
            }
            else{
                let newTime = toDate(laps[i])
                let lastTime = toDate(laps[i+1])
                let finalTime = toDate(endTime)
                let lap = newTime - lastTime
                lapArray[i] = toString(lap)
            }
        }
        
        
        
    }
    
    func toCsv(){
        csv = name + "," + endTime + ","
        
        if lapArray.count > 1 {
            csv = csv + lapArray[0] + ","
            
            for var i = 1 ; i < lapArray.count - 1 ; i++ {
                csv = csv + lapArray[i] + ","
            }
            
            
        }
    }
    
    
    //Notes about toCsv
    //This is for only the individual runner object will be used to prep the data to be entered into a single string that is 
    //csv compatible
    
    
    
    //Csv headings
    //Name, End Time, Lap
    
    //if race only has one lap so only an endtime dont record or export any laps, if it has multiple subtract and determine
    //each individual lap's duration
}