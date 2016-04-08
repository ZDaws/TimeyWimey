//
//  GlobalData.swift
//  TimeyWimey
//
//  Created by KUSKE, JOEL on 2/1/16.
//  Copyright © 2016 Frands. All rights reserved.
//

import Foundation

struct Global {
    //Events array that stores all of our data
    static var events: [Event] = []
    //This is used to load data on the timer and edit screen
    static var currentEvent: Int = 0
    static var eventsSaved: Bool = false
}
