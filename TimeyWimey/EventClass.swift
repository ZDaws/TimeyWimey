//
//  EventClass.swift
//  TimeyWimey
//
//  Created by CHERMAK, ZACHARY on 1/20/16.
//  Copyright © 2016 Frands. All rights reserved.
//

import Foundation
import UIKit



class Event: NSObject, NSCoding {
    //MARK: Properties
    
    var EventName: String = ""
    var RegisterArray: [Runner] = []
    var isOpen: Bool //if this boolean is read in as a true boolean then the event is an open race
    var isTiming: Bool
    var isDone: Bool
    var finalTime: String
    var timer: NSTimer = NSTimer()
    var displayTimeLabel = UILabel()
    
    // MARK: Archiving Paths
    
    static let DocumentsDirectory = NSFileManager().URLsForDirectory(.DocumentDirectory, inDomains: .UserDomainMask).first!
    static let ArchiveURL = DocumentsDirectory.URLByAppendingPathComponent("Global.events")

    //MARK: Types
    
    struct PropertyKey {
        static let eventNameKey = "eventname"
        static let isOpenKey = "isopen"
        static let isTimingKey = "istiming"
        static let isDoneKey = "isdone"
        static let finalTimeKey = "finaltime"
        static let registerArrayKey = "registerarray"
        static let timerKey = "timer"
        static let displayTimeLabelKey = "displaytimelabel"
    }
    
    //MARK: Initialization
    
    init( EventName: String, typeOpen: Bool, isTiming: Bool, isDone: Bool, finalTime: String ) {
        self.EventName = EventName
        self.isOpen = typeOpen
        self.isDone = isDone
        self.isTiming = isTiming
        self.finalTime = finalTime
        if isOpen == true {
            for var i = 0 ; i < 10 ; i++ {
                self.RegisterArray.append(Runner(n: "New Runner"))
            }
        }
        else {
            for var a = 0 ; a < 4 ; a++ {
                self.RegisterArray.append(Runner(n: "New Runner"))
            }
        }
        
        super.init()
    }
    
    //MARK: NSCoding
    func encodeWithCoder(aCoder: NSCoder) {
        aCoder.encodeObject(EventName, forKey: PropertyKey.eventNameKey)
        aCoder.encodeObject(RegisterArray, forKey: PropertyKey.registerArrayKey)
        aCoder.encodeObject(isOpen, forKey: PropertyKey.isOpenKey)
        aCoder.encodeObject(isTiming, forKey: PropertyKey.isTimingKey)
        aCoder.encodeObject(isDone, forKey: PropertyKey.isDoneKey)
        aCoder.encodeObject(finalTime, forKey: PropertyKey.finalTimeKey)
        aCoder.encodeObject(timer, forKey: PropertyKey.timerKey)
        aCoder.encodeObject(displayTimeLabel, forKey: PropertyKey.displayTimeLabelKey)
        
    }
    
//    func initWithCoder(coder aDecoder: NSCoder) -> Event {
//        self.EventName = aDecoder.decodeObjectForKey("eventname") as! String
//        self.isOpen = aDecoder.decodeBoolForKey("isopen")
//        self.isTiming = aDecoder.decodeBoolForKey("istiming")
//        self.isDone = aDecoder.decodeBoolForKey("isdone")
//        self.finalTime = aDecoder.decodeObjectForKey("finaltime") as! String
//        return self
//    }
    
    
    required convenience init?(coder aDecoder: NSCoder){
        let EventName = aDecoder.decodeObjectForKey(PropertyKey.eventNameKey) as! String
        
        let isOpen = aDecoder.decodeBoolForKey(PropertyKey.isOpenKey)
        
        let isTiming = aDecoder.decodeBoolForKey(PropertyKey.isTimingKey)
        
        let isDone = aDecoder.decodeBoolForKey(PropertyKey.isDoneKey)
        
        let finalTime = aDecoder.decodeObjectForKey(PropertyKey.finalTimeKey) as! String
        
        self.init(EventName: EventName, typeOpen: isOpen, isTiming: isTiming, isDone: isDone, finalTime: finalTime)
    }
    
    
}

