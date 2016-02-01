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
    
    
    //functions
    
    init(name: String, typeOpen: Bool ) {
        EventName = "New Event"
        isOpen = typeOpen
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
    
}
