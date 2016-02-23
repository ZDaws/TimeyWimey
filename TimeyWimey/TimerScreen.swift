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
    var lapButtons:[CustomButton] = []
    //Stop buttons
    var stopButtons:[CustomButton] = []
    //Runner and Button label height
    var labelH = CGFloat()
    //Timer label height
    var timerLabelH = CGFloat()
    //Start button height
    //start button
    var startButton = UIButton()
    var startH = CGFloat()
    //Number of runners
    var numRun = Int()
    //If the timer has started     ***Maybe make started a global instance variable for event class***
    var started = false
    
    
    
    var timer: NSTimer = NSTimer()
    var startTime = NSTimeInterval()
    
    
    
    
    override func viewDidLoad() {
        numRun = Global.events[Global.currentEvent].RegisterArray.count
        //Set the screen size using variables screenSize, width, height
        width = screenSize.width
        height = screenSize.height
        timerLabelH = (height - navBar) / 10
        startH = timerLabelH
        //7/10 the screen width   ***Make sure lableL + 2 * buttonL < 1***
        labelL = ( 7 * width) / 10
        //1/10 the screen width
        buttonL = ( 1.25 * width) / 10
        horz = (width - (labelL + (buttonL * 2))) / 4
        vert = horz
        labelH = (height - ((vert * 4) + navBar + timerLabelH + startH)) / CGFloat(numRun)
        
        
        
        //layout screen
        for (var x = 0 ; x < numRun ; x++) {
            //Layout runners
            labels.append(UILabel(frame: CGRect(x: 3 * horz + buttonL * 2, y: (vert * 2) + timerLabelH + navBar + (CGFloat(x) * labelH), width: labelL, height: labelH)))
            if x % 2 == 0   {
                labels[x].backgroundColor = UIColor.blueColor()
            } else {
                labels[x].backgroundColor = UIColor.greenColor()
            }
            labels[x].text = Global.events[event].RegisterArray[x].name
            labels[x].font = UIFont(name: "Courier New", size: (labelH * 2) / 3)
            self.view.addSubview(labels[x])
            
            
            //Layout lap buttons
            lapButtons.append(CustomButton(frame: CGRect(x: (horz * 2) + buttonL , y: (vert / CGFloat(1 + numRun)) + (vert * 2) + timerLabelH + navBar + (CGFloat(x) * labelH), width: buttonL, height: labelH - ((vert * 2) / CGFloat(1 + numRun))), x, false))
            lapButtons[x].backgroundColor = UIColor.blueColor()
            lapButtons[x].titleLabel!.font = UIFont(name: "Courier New", size: (labelH * 2) / 3)
            lapButtons[x].setTitle("Lap", forState: .Normal)
            lapButtons[x].layer.cornerRadius = 10.0
            lapButtons[x].clipsToBounds = true
            lapButtons[x].addTarget(self, action: "lap:", forControlEvents: .TouchUpInside)
            
            self.view.addSubview(lapButtons[x])
            
            //Layout stop buttons
            stopButtons.append(CustomButton(frame: CGRect(x: (horz ) , y: (vert / CGFloat(1 + numRun)) + (vert * 2) + timerLabelH + navBar + (CGFloat(x) * labelH), width: buttonL, height: labelH - ((vert * 2) / CGFloat(1 + numRun))), x, true))
            stopButtons[x].backgroundColor = UIColor.redColor()
            stopButtons[x].titleLabel!.font = UIFont(name: labels[x].font!.fontName, size: (labelH * 2) / 3)
            stopButtons[x].setTitle("Stop", forState: .Normal)
            stopButtons[x].layer.cornerRadius = 10.0
            stopButtons[x].clipsToBounds = true
            stopButtons[x].addTarget(self, action: "stop:", forControlEvents: .TouchUpInside)
            
            self.view.addSubview(stopButtons[x])
        }
            
        
        //Add a master clock at the top
        displayTimeLabel = UILabel(frame: CGRect(x: width / 4, y: navBar + vert, width: width / 2, height: timerLabelH))
        displayTimeLabel.backgroundColor = UIColor.blackColor()
        displayTimeLabel.textColor = UIColor.whiteColor()
        displayTimeLabel.font = UIFont(name: "Courier New", size: (timerLabelH * 2) / 3)
        displayTimeLabel.text = "00:00:00"
        displayTimeLabel.textAlignment = .Center
        self.view.addSubview(displayTimeLabel)
        
        //Add start button that will disapear when pressed at the bottom
        if numRun > 0   {
            startButton = UIButton(frame: CGRect(x: width / 4, y: navBar + (vert * 3) + timerLabelH + (labelH * CGFloat(numRun)), width: width / 2, height: startH))
            startButton.backgroundColor = UIColor.greenColor()
            startButton.setTitle("Start", forState: .Normal)
            startButton.layer.cornerRadius = 10.0
            startButton.titleLabel!.font = UIFont(name: "Courier New", size: (timerLabelH * 2) / 3)
            startButton.clipsToBounds = true
            startButton.addTarget(self, action: "start:", forControlEvents: .TouchUpInside)
            self.view.addSubview(startButton)
        }
    }
    
    
    
    
    
    
    
    
    /*Start Button
    *
    */
    func start(button: UIButton)   {
        if started == false {
            let aSelector : Selector = "updateTime"
            //makes a new timer where the time updates every .01 seconds
            timer = NSTimer.scheduledTimerWithTimeInterval(0.01, target: self, selector: aSelector, userInfo: nil, repeats: true)
            startTime = NSDate.timeIntervalSinceReferenceDate()
            started = true
        }
    }
    
    /*Lap Button
    *
    */
    func lap(button: CustomButton)  {
        
        print("\(displayTimeLabel.text!)")
        Global.events[event].RegisterArray[button.numRunner].lapArray.append(displayTimeLabel.text!)
        
        
    }
    
    
    /*Stop Button
    *
    */
    func stop(button: CustomButton){
        
        print("Stoped runner #\(button.numRunner)")
        
        
        //lay a label over the stop and lap buttons
        let coverLabel = UILabel(frame: CGRect(x: horz, y: navBar + (vert * 2) + timerLabelH + (labelH * CGFloat(button.numRunner)), width: (buttonL * 2) + horz, height: labelH))
        coverLabel.backgroundColor = UIColor.greenColor()
        coverLabel.text = "\(displayTimeLabel.text!)"
        coverLabel.font = UIFont(name: "Courier New", size: (timerLabelH * 2) / 3)
        coverLabel.textAlignment = .Center
        
        self.view.addSubview(coverLabel)
        
        //If all runners == stop then...
        //timer.invalidate()
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
