//
//  EventClass.swift
//  TimeyWimey
//
//  Created by CHERMAK, ZACHARY on 1/20/16.
//  Copyright © 2016 Frands. All rights reserved.
//

import Foundation
import UIKit

class Event {
    
    //instance variables
    var EventName: String = ""
    var RegisterArray: [Runner] = []
    var isOpen: Bool //if this boolean is read in as a true boolean then the event is an open race
    var isTiming: Bool
    var isDone: Bool
    var finalTime: String
    var timer: NSTimer = NSTimer()
    var displayTimeLabel = UILabel()
    
    //functions
    
    init(name: String, typeOpen: Bool ) {
        EventName = "New Event"
        isOpen = typeOpen
        isDone = false
        isTiming = false
        finalTime = "00:00:00"
        if isOpen == true {
            for var i = 0 ; i < 10 ; i++ {
                RegisterArray.append(Runner(n: "New Runner"))
            }
        }
        else {
            for var a = 0 ; a < 4 ; a++ {
                RegisterArray.append(Runner(n: "New Runner"))
            }
        }
    }
    
    init(coder aDecoder: NSCoder!){
        self.EventName = aDecoder.decodeObjectForKey("eventname") as! String
        self.isOpen = aDecoder.decodeBoolForKey("isopen")
        self.isTiming = aDecoder.decodeBoolForKey("istiming")
        self.isDone = aDecoder.decodeBoolForKey("isdone")
        self.finalTime = aDecoder.decodeObjectForKey("finaltime") as! String
    }
    
    func initWithCoder(coder aDecoder: NSCoder) -> Event {
        self.EventName = aDecoder.decodeObjectForKey("eventname") as! String
        self.isOpen = aDecoder.decodeBoolForKey("isopen")
        self.isTiming = aDecoder.decodeBoolForKey("istiming")
        self.isDone = aDecoder.decodeBoolForKey("isdone")
        self.finalTime = aDecoder.decodeObjectForKey("finaltime") as! String
        return self
    }
    
    func encodeWithCoder(aCoder: NSCoder!) {
        aCoder.encodeObject(EventName, forKey: "eventname")
        aCoder.encodeObject(RegisterArray, forKey: "registerarray")
        aCoder.encodeObject(isOpen, forKey: "isopen")
        aCoder.encodeObject(isTiming, forKey: "istiming")
        aCoder.encodeObject(isDone, forKey: "isdone")
        aCoder.encodeObject(finalTime, forKey: "finaltime")
        aCoder.encodeObject(timer, forKey: "timer")
        aCoder.encodeObject(displayTimeLabel, forKey: "displaytimelabel")
        
    }
    
}

