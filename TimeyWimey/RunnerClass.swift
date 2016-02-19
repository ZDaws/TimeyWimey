//
//  Runner Class.swift
//  Passing Test
//
//  Created by CHERMAK, ZACHARY on 12/16/15.
//  Copyright © 2015 CHERMAK, ZACHARY. All rights reserved.
//

import Foundation
import UIKit

class Runner {
    //Instance Variables 
    var name: String
    var endTime: String
    var lapArray: [String] = []
    var fLapArray: [String] = [] //the final array with all the proper time duration values, use in toCsv function
    var csv = "" //Single string used to export into CSV file

    
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
    
    
    init(n: String)  {
        name = n
        endTime = "00:00:00"
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
        let minCalendarUnit: NSCalendarUnit = [.Minute]

        var laps: [String] = []
        
        //loop to go through the array to allow us to do arithmetic with it 
        for var i = 0 ; i < lapArray.count - 1; i++ {
            if i == 0 {
                laps[i] = lapArray[i]
            }
                //for the indexes in the array that will do the subractions with other elements of the array
            else if i < lapArray.count - 2 {
                let newTime = toDate(laps[i])
                let lastTime = toDate(laps[i+1])
                
                //this does the arithmetic to find the time in minutes followed by seconds between the two variables and 
                //adjusting for sign difference to keep it positive even with the backwards order
                let lap = userCalendar.components(minCalendarUnit, fromDate: newTime, toDate: lastTime, options: [])
                let finalDate = userCalendar.dateFromComponents(lap)
                
                fLapArray[i] = toString(finalDate!)
            }
                //does the subtraction for the last index and the final end time to get the last indexes difference in time
            else {
                let lastTime = toDate(laps[i+1])
                let finalTime = toDate(endTime)
                let lap = userCalendar.components(minCalendarUnit, fromDate: lastTime, toDate: finalTime, options: [])
                let finalDate = userCalendar.dateFromComponents(lap)
                fLapArray[i] = toString(finalDate!)
            }
        }
        
        
        
    }
    
    func toCsv(){
        csv = name + "," + endTime + ","
        
        if fLapArray.count > 1 {
            csv = csv + fLapArray[0] + ","
            
            for var i = 1 ; i < fLapArray.count - 1 ; i++ {
                csv = csv + fLapArray[i] + ","
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