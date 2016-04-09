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
    
    func initRunnerArray() {
        if RegisterArray.isEmpty {
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
        }
    }
    
    init(EventName: String, isOpen: Bool) {
        self.EventName = EventName
        self.RegisterArray = []
        self.isOpen = isOpen
        self.isTiming = false
        self.isDone = false
        self.finalTime = "00:00:00"
        super.init()
        initRunnerArray()
    }
    
    init(EventName: String, RegisterArray: [Runner], isOpen: Bool, isTiming: Bool, isDone: Bool, finalTime: String, displayTimeLabel: UILabel) {
        self.EventName = EventName
        self.isOpen = isOpen
        self.isDone = isDone
        self.isTiming = isTiming
        self.finalTime = finalTime
        self.displayTimeLabel = displayTimeLabel
        self.RegisterArray = RegisterArray
        super.init()
        initRunnerArray()
    }
    
    //MARK: NSCoding
    func encodeWithCoder(aCoder: NSCoder) {
        aCoder.encodeObject(EventName, forKey: PropertyKey.eventNameKey)
        aCoder.encodeObject(RegisterArray, forKey: PropertyKey.registerArrayKey)
        aCoder.encodeBool(isOpen, forKey: PropertyKey.isOpenKey)
        aCoder.encodeBool(isTiming, forKey: PropertyKey.isTimingKey)
        aCoder.encodeBool(isDone, forKey: PropertyKey.isDoneKey)
        aCoder.encodeObject(finalTime, forKey: PropertyKey.finalTimeKey)
        aCoder.encodeObject(displayTimeLabel, forKey: PropertyKey.displayTimeLabelKey)
    }
    
    required convenience init?(coder aDecoder: NSCoder){
        let EventName = aDecoder.decodeObjectForKey(PropertyKey.eventNameKey) as! String
        let RegisterArray = aDecoder.decodeObjectForKey(PropertyKey.registerArrayKey) as! [Runner]
        let isOpen = aDecoder.decodeBoolForKey(PropertyKey.isOpenKey)
        let isTiming = aDecoder.decodeBoolForKey(PropertyKey.isTimingKey)
        let isDone = aDecoder.decodeBoolForKey(PropertyKey.isDoneKey)
        let finalTime = aDecoder.decodeObjectForKey(PropertyKey.finalTimeKey) as! String
        let displayTimeLabel = aDecoder.decodeObjectForKey(PropertyKey.displayTimeLabelKey) as! UILabel

        self.init(EventName: EventName, RegisterArray: RegisterArray, isOpen: isOpen, isTiming: isTiming, isDone: isDone, finalTime: finalTime, displayTimeLabel: displayTimeLabel)
    }
    
    
}

