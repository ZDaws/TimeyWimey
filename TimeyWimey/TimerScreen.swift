//
//  TimerScreen.swift
//  TimeyWimey
//
//  Created by KUSKE, JOEL on 1/25/16.
//  Copyright © 2016 Frands. All rights reserved.
//

import UIKit

class TimerScreen: UIViewController {
    
    //need one of these for every Runner
    
    @IBOutlet weak var displayTimeLabel: UILabel!
    
    //Variables for finding the screen size
    var screenSize: CGRect = UIScreen.mainScreen().bounds
    var width: CGFloat = 0.0
    var height: CGFloat = 0.0
    var timer: NSTimer = NSTimer()
    var startTime = NSTimeInterval()
    
    func start(){
        let aSelector : Selector = "updateTime"
        //makes a new timer where the time updates every .01 seconds
        timer = NSTimer.scheduledTimerWithTimeInterval(0.01, target: self, selector: aSelector, userInfo: nil, repeats: true)
        startTime = NSDate.timeIntervalSinceReferenceDate()
    }
    
    func lap(){
        
    }
    
    //only call the stop function when all of the runners have finished
    func stop(){
        timer.invalidate()
    }
    func updateTime() {
        let currentTime = NSDate.timeIntervalSinceReferenceDate()
        
        //Find the difference between current time and start time.
        var elapsedTime: NSTimeInterval = currentTime - startTime
        
        //calculate the minutes in elapsed time.
        let minutes = UInt8(elapsedTime / 60.0)
        elapsedTime -= (NSTimeInterval(minutes) * 60)
        
        //calculate the seconds in elapsed time.
        let seconds = UInt8(elapsedTime)
        elapsedTime -= NSTimeInterval(seconds)
        
        //find out the fraction of milliseconds to be displayed.
        let fraction = UInt8(elapsedTime * 100)
        
        //add the leading zero for minutes, seconds and millseconds and store them as string constants
        
        let strMinutes = String(format: "%02d", minutes)
        let strSeconds = String(format: "%02d", seconds)
        let strFraction = String(format: "%02d", fraction)
        
        //concatenate minuets, seconds and milliseconds as assign it to the UILabel
        displayTimeLabel.text = "\(strMinutes):\(strSeconds):\(strFraction)"
    }
    
    override func viewDidLoad() {
        //Set the screen size using variables screenSize, width, height
        width = screenSize.width
        height = screenSize.height
        
        //temporary testing
        start()
        //testing
        
        //Lay out all runners with lap and stop buttons from 120 pixels and down until 60 from the bottom
        
        
        
        //Add a master clock at the top 
        
        
        
        //Add start button that will disapear when pressed at the bottom
        
        
        
    }
    
    
    
    
    

}
