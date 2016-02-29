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
    //var displayTimeLabel = UILabel()
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
    //start button
    var startButton = UIButton()
    //Start button height
    var startH = CGFloat()
    //Number of runners
    var numRun = Int()

    
    
    
    //var timer: NSTimer = NSTimer()    //Make these global but through event class, each event will have its own timer
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
            
            
            if Global.events[event].isDone == false  {
            
                //Layout lap buttons
                lapButtons.append(CustomButton(frame: CGRect(x: (horz * 2) + buttonL , y: (vert / CGFloat(1 + numRun)) + (vert * 2) + timerLabelH + navBar + (CGFloat(x)    * labelH), width: buttonL, height: labelH - ((vert * 2) / CGFloat(1 + numRun))), x, false))
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
            
            } else {       //If the event is already done
                
                //Lay out green final time buttons
                
                let coverLabel = UILabel(frame: CGRect(x: horz, y: navBar + (vert * 2) + timerLabelH + (labelH * CGFloat(x)), width: (buttonL * 2) + horz, height: labelH))
                coverLabel.backgroundColor = UIColor.greenColor()
                coverLabel.text = "\(Global.events[event].RegisterArray[x].endTime)"
                coverLabel.font = UIFont(name: "Courier New", size: (timerLabelH * 2) / 3)
                coverLabel.textAlignment = .Center
                
                self.view.addSubview(coverLabel)
                
               
                
            }
            
        }
            
        
        //Add a master clock at the top
        Global.events[event].displayTimeLabel = UILabel(frame: CGRect(x: width / 4, y: navBar + vert, width: width / 2, height: timerLabelH))
        Global.events[event].displayTimeLabel.backgroundColor = UIColor.blackColor()
        Global.events[event].displayTimeLabel.textColor = UIColor.whiteColor()
        Global.events[event].displayTimeLabel.font = UIFont(name: "Courier New", size: (timerLabelH * 2) / 3)
        Global.events[event].displayTimeLabel.text = Global.events[event].finalTime
        Global.events[event].displayTimeLabel.textAlignment = .Center
        self.view.addSubview(Global.events[event].displayTimeLabel)
        
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
    //End of viewDidLoad
    
    
    
    
    
    
    
    /*Start Button
    *
    */
    func start(button: UIButton)   {
        if Global.events[event].isTiming == false && Global.events[event].isDone == false  {
            let aSelector : Selector = "updateTime"
            //makes a new timer where the time updates every .01 seconds
            Global.events[event].timer = NSTimer.scheduledTimerWithTimeInterval(0.01, target: self, selector: aSelector, userInfo: nil, repeats: true)
            startTime = NSDate.timeIntervalSinceReferenceDate()
            Global.events[event].isTiming = true
            
        }
    }
    
    /*Lap Button
    *
    */
    func lap(button: CustomButton)  {
        
        print("\(Global.events[event].displayTimeLabel.text!)")
        Global.events[event].RegisterArray[button.numRunner].lapArray.append(Global.events[event].displayTimeLabel.text!)
        
        
    }
    
    
    /*Stop Button
    *
    */
    var count = 0
    func stop(button: CustomButton){
        count++
        print("Stoped runner #\(button.numRunner)")
        print(Global.events[event].RegisterArray[button.numRunner].lapArray)
        
        //lay a label over the stop and lap buttons
        let coverLabel = UILabel(frame: CGRect(x: horz, y: navBar + (vert * 2) + timerLabelH + (labelH * CGFloat(button.numRunner)), width: (buttonL * 2) + horz, height: labelH))
        coverLabel.backgroundColor = UIColor.greenColor()
        coverLabel.text = "\(Global.events[event].displayTimeLabel.text!)"
        coverLabel.font = UIFont(name: "Courier New", size: (timerLabelH * 2) / 3)
        coverLabel.textAlignment = .Center
        
        self.view.addSubview(coverLabel)
        
        stopButtons[button.numRunner].removeFromSuperview()
        lapButtons[button.numRunner].removeFromSuperview()
        
        //When count is equal to the number of runners when the stop button is pressed, the timer stops.
        if(count == numRun){
            Global.events[event].timer.invalidate()
            Global.events[event].isDone = true
            Global.events[event].isTiming = false
            Global.events[event].finalTime = Global.events[event].displayTimeLabel.text!
        }
        
        Global.events[event].RegisterArray[button.numRunner].endTime = "\(Global.events[event].displayTimeLabel.text!)"

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
        
        Global.events[event].displayTimeLabel.text = "\(strMinutes):\(strSeconds):\(strFraction)"
        print("\(Global.events[event].displayTimeLabel.text)")
        
        
    }
    
  
    
    
    @IBAction func backToMain(sender: UIBarButtonItem) {
        
        performSegueWithIdentifier("timerToMainSegue", sender: self)
            
    }
    
    
    
    @IBAction func editButton(sender: UIBarButtonItem) {
        if Global.events[event].isTiming == false  {
            
            performSegueWithIdentifier("timerToSaveSegue", sender: self)
        }
    }
    
    
    

}
