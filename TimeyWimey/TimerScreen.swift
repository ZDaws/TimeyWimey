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
    
    
    //Variables for finding the screen size
    var screenSize: CGRect = UIScreen.mainScreen().bounds
    var width: CGFloat = 0.0
    var height: CGFloat = 0.0
    //Navigaiton bar height
    let navBar: CGFloat = 60
    //horizontal spacing between nav bar and text fields
    var horz = CGFloat()
    //vertical spacing between nav bar and text fields
    var vert = CGFloat()
    //button length
    var buttonL = CGFloat()
    //Label length
    var labelL = CGFloat()
    //current event
    let event: Int = Global.currentEvent
    //Timer label
    var displayTimeLabel = UILabel()
    //Runner labels
    var labels:[UILabel] = []
    //Lap buttons
    //var lapButtons:[LapButton] = []
    //Stop buttons
    //var stopButtons:[StopButton] = []
    //Runner and Button label height
    var labelH = CGFloat()
    //Timer label height
    var timerLabelH = CGFloat()
    //Number of runners
    var numRun = Int()
    
    
    
    
    var timer: NSTimer = NSTimer()
    var startTime = NSTimeInterval()
    
    
    
    
    override func viewDidLoad() {
        numRun = Global.events[Global.currentEvent].RegisterArray.count
        //Set the screen size using variables screenSize, width, height
        width = screenSize.width
        height = screenSize.height
        //1/10 of the height
        timerLabelH = (height - navBar) / 10
        //1/2 the screen width
        labelL = ( 7 * width) / 10
        //1/5 the screen width
        buttonL = ( 1 * width) / 10
        horz = (width - (labelL + (buttonL * 2))) / 4
        vert = horz
        labelH = (height - ((vert * 3) + navBar + timerLabelH)) / CGFloat(numRun)
        
        
        
        //layout screen
        for (var x = 0 ; x < numRun ; x++) {
            
            labels.append(UILabel(frame: CGRect(x: 3 * horz + buttonL * 2, y: (vert * 2) + timerLabelH + navBar + (CGFloat(x) * labelH), width: labelL, height: labelH)))
            if x % 2 == 0   {
                labels[x].backgroundColor = UIColor.blueColor()
            } else {
                labels[x].backgroundColor = UIColor.greenColor()
            }
            labels[x].text = Global.events[event].RegisterArray[x].name
            labels[x].font = UIFont(name: labels[x].font!.fontName, size: (labelH * 2) / 3)
            self.view.addSubview(labels[x])
            
        }
            
        
        //Add a master clock at the top
        displayTimeLabel = UILabel(frame: CGRect(x: width / 4, y: navBar + vert, width: width / 2, height: timerLabelH))
        displayTimeLabel.backgroundColor = UIColor.blackColor()
        displayTimeLabel.textColor = UIColor.whiteColor()
        displayTimeLabel.font = UIFont(name: displayTimeLabel.font!.fontName, size: (timerLabelH * 2) / 3)
        displayTimeLabel.text = "00:00:00"
        displayTimeLabel.textAlignment = .Center
        self.view.addSubview(displayTimeLabel)
        //Add start button that will disapear when pressed at the bottom
        
        
        
    }
    
    
    
    
    
    
    
    
    
    
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
    
   
    
    
    
    
    
    @IBAction func backToMain(sender: UIBarButtonItem) {
        performSegueWithIdentifier("timerToMainSegue", sender: self)
        
    }
    
    
    
    @IBAction func editButton(sender: UIBarButtonItem) {
        performSegueWithIdentifier("timerToSaveSegue", sender: self)
        
    }
    
    
    

}
