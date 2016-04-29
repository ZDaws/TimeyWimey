//
//  TimerScreen.swift
//  TimeyWimey
//
//  Created by HOLM, JOEL on 1/25/16.
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
    //Runner Labels total space
    var labelSpace = CGFloat()
    //Varibale used in stop to count the number of runners stoped to know when to end the clock
    var count = 0
    //var timer: NSTimer = NSTimer()    //Make these global but through event class, each event will have its own timer
    var startTime = NSTimeInterval()
    //Used to do timer stuff in stop function for relay events
    var sum = "00:00:00"
    
    @IBOutlet weak var eventTitle: UINavigationItem!
    
    override func viewDidLoad() {
        eventTitle.title = Global.events[event].EventName
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
        
        //These weird numbers are just calculating how tall the label can be to fit in each string
        labelH = (buttonL / 4) * (50.0 / 31.0) * (3.0 / 2.0)
        
        //If the total space of the runner labels is to long make it fit according to the screen
        labelSpace = labelH * CGFloat(numRun)
        if labelSpace >= (height - ((vert * 4) + navBar + timerLabelH + startH))    {
            labelH = (height - ((vert * 4) + navBar + timerLabelH + startH)) / CGFloat(numRun)
            
        }
        
        //Background layer
        let background = UILabel(frame: CGRect(x: (horz * 3) + (buttonL * 2) - 1, y: navBar + (vert * 2) + timerLabelH, width: labelL + 2, height: labelH * CGFloat(numRun)))
        background.backgroundColor = UIColor.blackColor()
        self.view.addSubview(background)
        
        /*layout screen labels and buttons
         * For both open and relay set the runner labels on the screen
         * However only for open place the buttons
         */
        for (var x = 0 ; x < numRun ; x++) {
            
            //Layout runners,  Will always be fired
            labels.append(UILabel(frame: CGRect(x: 3 * horz + buttonL * 2, y: ((vert * 2) + timerLabelH + navBar + (CGFloat(x) * labelH)) + 1, width: labelL, height: labelH - 2)))
            if x % 2 == 0   {
                labels[x].backgroundColor = UIColor(red: 0, green: 0.4157, blue: 1, alpha: 1.0)
            } else {
                labels[x].backgroundColor = UIColor(red: 0, green: 0.898, blue: 0.0118, alpha: 1.0)
            }
            labels[x].text = Global.events[event].RegisterArray[x].name
            labels[x].font = UIFont(name: "Courier New", size: (labelH * 2) / 3)
            self.view.addSubview(labels[x])
            
            if Global.events[event].isOpen  {
                //If the event is not done, so either not started or ongoing
                if Global.events[event].isDone == false {
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
                    stopButtons.append(CustomButton(frame: CGRect(x: (horz ) , y: (vert / CGFloat(1 + numRun)) + (vert * 2) + timerLabelH + navBar +    (CGFloat(x) * labelH), width: buttonL, height: labelH - ((vert * 2) / CGFloat(1 + numRun))), x, true))
                    stopButtons[x].backgroundColor = UIColor.redColor()
                    stopButtons[x].titleLabel!.font = UIFont(name: labels[x].font!.fontName, size: (labelH * 2) / 3)
                    stopButtons[x].setTitle("Stop", forState: .Normal)
                    stopButtons[x].layer.cornerRadius = 10.0
                    stopButtons[x].clipsToBounds = true
                    stopButtons[x].addTarget(self, action: "stop:", forControlEvents: .TouchUpInside)
                    
                    self.view.addSubview(stopButtons[x])
                    
                    //If the runner has an endtime put the green bar over and remove lap and stop buttons
                    if Global.events[event].RegisterArray[x].endTime != "00:00:00"  {
                        
                        let coverLabel = UILabel(frame: CGRect(x: horz, y: navBar + (vert * 2) + timerLabelH + (labelH * CGFloat(x)), width: (buttonL * 2) + horz, height: labelH))
                        coverLabel.backgroundColor = UIColor.greenColor()
                        coverLabel.text = "\(Global.events[event].RegisterArray[x].endTime)"
                        coverLabel.font = UIFont(name: "Courier New", size: (timerLabelH * 2) / 3)
                        coverLabel.textAlignment = .Center
                        
                        self.view.addSubview(coverLabel)
                        
                        stopButtons[x].removeFromSuperview()
                        lapButtons[x].removeFromSuperview()
                        
                        count++
                    }
                    
                } else {
                    //If the event is done
                    //Lay out green final time buttons
                    let coverLabel = UILabel(frame: CGRect(x: horz, y: navBar + (vert * 2) + timerLabelH + (labelH * CGFloat(x)), width: (buttonL * 2) + horz, height: labelH))
                    coverLabel.backgroundColor = UIColor.greenColor()
                    coverLabel.text = "\(Global.events[event].RegisterArray[x].endTime)"
                    coverLabel.font = UIFont(name: "Courier New", size: (timerLabelH * 2) / 3)
                    coverLabel.textAlignment = .Center
                    
                    self.view.addSubview(coverLabel)
                    
                }
            }
            
        }
        //End of for-loop
        
        //If relay place buttons
        if Global.events[event].isOpen == false {
            
            //If it is a relay event that is not started only place the first lap and stop buttons
            if Global.events[event].isTiming == false && Global.events[event].isDone == false {
                stopButtons.append(CustomButton(frame: CGRect(x: (horz ) , y: (vert / CGFloat(1 + numRun)) + (vert * 2) + timerLabelH + navBar, width: buttonL, height: labelH - ((vert * 2) / CGFloat(1 + numRun))), 0, true))
                stopButtons[0].backgroundColor = UIColor.redColor()
                stopButtons[0].titleLabel!.font = UIFont(name: labels[0].font!.fontName, size: (labelH * 2) / 3)
                stopButtons[0].setTitle("Stop", forState: .Normal)
                stopButtons[0].layer.cornerRadius = 10.0
                stopButtons[0].clipsToBounds = true
                stopButtons[0].addTarget(self, action: "stop:", forControlEvents: .TouchUpInside)
                
                self.view.addSubview(stopButtons[0])
                
                lapButtons.append(CustomButton(frame: CGRect(x: (horz * 2) + buttonL , y: (vert / CGFloat(1 + numRun)) + (vert * 2) + timerLabelH + navBar, width: buttonL, height: labelH - ((vert * 2) / CGFloat(1 + numRun))), 0, false))
                lapButtons[0].backgroundColor = UIColor.blueColor()
                lapButtons[0].titleLabel!.font = UIFont(name: "Courier New", size: (labelH * 2) / 3)
                lapButtons[0].setTitle("Lap", forState: .Normal)
                lapButtons[0].layer.cornerRadius = 10.0
                lapButtons[0].clipsToBounds = true
                lapButtons[0].addTarget(self, action: "lap:", forControlEvents: .TouchUpInside)
                
                self.view.addSubview(lapButtons[0])
                
                
            } else {
                
                    /* If the event is ongoing, based on what count is place the green end
                    *  times over finished runners and one set of lap and stop buttons over the current runner ( count + 1 )
                    */
                
                    //See how many runners are finished to set count and set the coverLabels
                    for ( var i = 0 ; i < numRun ; i++)  {
                        
                        if Global.events[event].RegisterArray[i].endTime != "00:00:00"  {
                            let coverLabel = UILabel(frame: CGRect(x: horz, y: navBar + (vert * 2) + timerLabelH + (labelH * CGFloat(i)), width: (buttonL * 2) + horz, height: labelH))
                            coverLabel.backgroundColor = UIColor.greenColor()
                            coverLabel.text = "\(Global.events[event].RegisterArray[i].endTime)"
                            coverLabel.font = UIFont(name: "Courier New", size: (timerLabelH * 2) / 3)
                            coverLabel.textAlignment = .Center
                            
                            self.view.addSubview(coverLabel)
                            
                            count++
                        }
                        
                    }
                    
                    if count < numRun  {
                        stopButtons.append(CustomButton(frame: CGRect(x: (horz ) , y: (vert / CGFloat(1 + numRun)) + (vert * 2) + timerLabelH + navBar + (labelH * CGFloat(count)), width: buttonL, height: labelH - ((vert * 2) / CGFloat(1 + numRun))), 0, true))
                        stopButtons[0].backgroundColor = UIColor.redColor()
                        stopButtons[0].titleLabel!.font = UIFont(name: labels[0].font!.fontName, size: (labelH * 2) / 3)
                        stopButtons[0].setTitle("Stop", forState: .Normal)
                        stopButtons[0].layer.cornerRadius = 10.0
                        stopButtons[0].clipsToBounds = true
                        stopButtons[0].addTarget(self, action: "stop:", forControlEvents: .TouchUpInside)
                        
                        self.view.addSubview(stopButtons[0])
                        
                        lapButtons.append(CustomButton(frame: CGRect(x: (horz * 2) + buttonL , y: (vert / CGFloat(1 + numRun)) + (vert * 2) + timerLabelH + navBar + (labelH * CGFloat(count)), width: buttonL, height: labelH - ((vert * 2) / CGFloat(1 + numRun))), 0, false))
                        lapButtons[0].backgroundColor = UIColor.blueColor()
                        lapButtons[0].titleLabel!.font = UIFont(name: "Courier New", size: (labelH * 2) / 3)
                        lapButtons[0].setTitle("Lap", forState: .Normal)
                        lapButtons[0].layer.cornerRadius = 10.0
                        lapButtons[0].clipsToBounds = true
                        lapButtons[0].addTarget(self, action: "lap:", forControlEvents: .TouchUpInside)
                        
                        self.view.addSubview(lapButtons[0])
                    
                    }
                    
                
            
            }
            
        }
        
        //Add a master clock at the top
        Global.events[event].displayTimeLabel = UILabel(frame: CGRect(x: width / 4, y: navBar + vert, width: width / 2, height: timerLabelH))
        Global.events[event].displayTimeLabel.backgroundColor = UIColor.blackColor()
        Global.events[event].displayTimeLabel.textColor = UIColor.whiteColor()
        Global.events[event].displayTimeLabel.font = UIFont(name: "Courier New", size: (timerLabelH * 2) / 3)
        Global.events[event].displayTimeLabel.text = Global.events[event].finalTime
        Global.events[event].displayTimeLabel.textAlignment = .Center
        Global.events[event].displayTimeLabel.layer.cornerRadius = 20.0
        Global.events[event].displayTimeLabel.clipsToBounds = true
        self.view.addSubview(Global.events[event].displayTimeLabel)
        
        //Add start button that will disapear when pressed at the bottom
        if numRun > 0   {
            startButton = UIButton(frame: CGRect(x: width / 4, y: height - (vert + startH), width: width / 2, height: startH))
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
    
    /*Start Button Action
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
        if Global.events[event].isTiming {
            
            
            
            let userCalendar = NSCalendar.currentCalendar()
            let minCalUnit: NSCalendarUnit = [.Minute, .Second, .Nanosecond]
            sum = Global.events[event].displayTimeLabel.text!
            
            /* If Relay
            * Take the timerlabel time and subtract all of the previous laps for the current runner
            * so Global.events[event].displayTimeLabel - ( sum of previous end times  +  sum of laps for this runner  )
            */
            if Global.events[event].isOpen == false {
                
                
                
                //subtract end times from sum
                for ( var i = 0 ; i < count ; i++ )    {
                    
                    let tmpSum = toDate(sum)
                    let tmpEnd = toDate(Global.events[event].RegisterArray[i].endTime)
                    
                    let interval = userCalendar.components(minCalUnit, fromDate: tmpEnd, toDate: tmpSum, options:[])
                    let finalDate = userCalendar.dateFromComponents(interval)
                    
                    sum = toString(finalDate!)
                    
                }
                
                
                print(sum)
                Global.events[event].RegisterArray[count].lapArray.append(sum)
            } else  {
                print(sum)
                Global.events[event].RegisterArray[button.numRunner].lapArray.append(sum)

            }
            
                        
                
            //Animate the button for like half a second
            UIView.animateWithDuration( 1 , animations: {
                self.lapButtons[button.numRunner].backgroundColor = UIColor.whiteColor()
            })
            UIView.animateWithDuration( 1 , animations: {
                self.lapButtons[button.numRunner].backgroundColor = UIColor.blueColor()
            })
        }
        
    }
    
    /*Stop Button
     *
     */
    func stop(button: CustomButton){
        
        if Global.events[event].isTiming    {
            count++
           
            
            
            //If open just simply place a green final time label over the buttons
            if Global.events[event].isOpen  {
                
                //get rid of buttons for open
                stopButtons[button.numRunner].removeFromSuperview()
                lapButtons[button.numRunner].removeFromSuperview()
                
                
                //Store final time to global data
                Global.events[event].RegisterArray[button.numRunner].endTime = Global.events[event].displayTimeLabel.text!
                
                //lay a label over the stop and lap buttons
                let coverLabel = UILabel(frame: CGRect(x: horz, y: navBar + (vert * 2) + timerLabelH + (labelH * CGFloat(button.numRunner)), width: (buttonL * 2) + horz, height: labelH))
                coverLabel.backgroundColor = UIColor.greenColor()
                coverLabel.text = "\(Global.events[event].displayTimeLabel.text!)"
                coverLabel.font = UIFont(name: "Courier New", size: (timerLabelH * 2) / 3)
                coverLabel.textAlignment = .Center
                
                self.view.addSubview(coverLabel)
                
                
                
            } else {
                //If relay add next runners lap and stop buttons and place green final time label over finished runner's buttons
                
                //get rid of buttons
                stopButtons[0].removeFromSuperview()
                stopButtons.removeAtIndex(0)
                lapButtons[0].removeFromSuperview()
                lapButtons.removeAtIndex(0)
  
                //So take the top time minus the sum of all times underneath that runner
                //sum = Global.events[event].displayTimeLabel.text! - sum of previous runners
                let userCalendar = NSCalendar.currentCalendar()
                let minCalUnit: NSCalendarUnit = [.Minute, .Second, .Nanosecond]

                sum = Global.events[event].displayTimeLabel.text!
                
                //Subtract the the previous runners final times from displayTime label
                for ( var i = 0 ; i < count - 1 ; i++ )    {
                    let tmpSum = toDate(sum)
                    let tmpEnd = toDate(Global.events[event].RegisterArray[i].endTime)
                    
                    let interval = userCalendar.components(minCalUnit, fromDate: tmpEnd, toDate: tmpSum, options:[])
                    let finalDate = userCalendar.dateFromComponents(interval)

                    sum = toString(finalDate!)
                }
                
                //If count <= numRun place a new lap and stop buttons down
                if count <= numRun - 1 {
                    
                    stopButtons.append(CustomButton(frame: CGRect(x: horz , y: (vert / CGFloat(1 + numRun)) + (vert * 2) + timerLabelH + navBar + (labelH * CGFloat(count)), width: buttonL, height: labelH - ((vert * 2) / CGFloat(1 + numRun))), 0, true))
                    stopButtons[0].backgroundColor = UIColor.redColor()
                    stopButtons[0].titleLabel!.font = UIFont(name: labels[0].font!.fontName, size: (labelH * 2) / 3)
                    stopButtons[0].setTitle("Stop", forState: .Normal)
                    stopButtons[0].layer.cornerRadius = 10.0
                    stopButtons[0].clipsToBounds = true
                    stopButtons[0].addTarget(self, action: "stop:", forControlEvents: .TouchUpInside)
                    
                    self.view.addSubview(stopButtons[0])
                    lapButtons.append(CustomButton(frame: CGRect(x: (horz * 2) + buttonL , y: (vert / CGFloat(1 + numRun)) + (vert * 2) + timerLabelH + navBar + (labelH * CGFloat(count)), width: buttonL, height: labelH - ((vert * 2) / CGFloat(1 + numRun))), 0, false))
                    lapButtons[0].backgroundColor = UIColor.blueColor()
                    lapButtons[0].titleLabel!.font = UIFont(name: "Courier New", size: (labelH * 2) / 3)
                    lapButtons[0].setTitle("Lap", forState: .Normal)
                    lapButtons[0].layer.cornerRadius = 10.0
                    lapButtons[0].clipsToBounds = true
                    lapButtons[0].addTarget(self, action: "lap:", forControlEvents: .TouchUpInside)
                    
                    self.view.addSubview(lapButtons[0])
                    
                }
                //lay a label over the stop and lap buttons
                let coverLabel = UILabel(frame: CGRect(x: horz, y: navBar + (vert * 2) + timerLabelH + (labelH * CGFloat(count - 1)), width: (buttonL * 2) + horz, height: labelH))
                coverLabel.backgroundColor = UIColor.greenColor()
                coverLabel.text = "\(sum)"
                coverLabel.font = UIFont(name: "Courier New", size: (timerLabelH * 2) / 3)
                coverLabel.textAlignment = .Center
                
                self.view.addSubview(coverLabel)
                
                //Store final time to global data
                Global.events[event].RegisterArray[count - 1].endTime = sum
                print("This is sum: \(sum)")
                
            }
            
            
            //When count is equal to the number of runners when the stop button is pressed, the timer stops.
            if(count == numRun) {
                Global.events[event].timer.invalidate()
                Global.events[event].isDone = true
                Global.events[event].isTiming = false
                Global.events[event].finalTime = Global.events[event].displayTimeLabel.text!
                for runner in Global.events[event].RegisterArray   {
                    runner.lapDur()
                }
            }
        
        }
    }
    //end of stop
    
    
    
    
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
        
    }
    
    @IBAction func backToMain(sender: UIBarButtonItem) {
        
        performSegueWithIdentifier("timerToMainSegue", sender: self)
        
    }
    
    @IBAction func editButton(sender: UIBarButtonItem) {
        if Global.events[event].isTiming == false  {
            
            if Global.events[event].EventName == "" {
                Global.events[event].EventName = "New Event"
            }
            
            performSegueWithIdentifier("timerToSaveSegue", sender: self)
        }
    }
    
    
    
    @IBAction func previewButton(sender: UIBarButtonItem) {
        
        if Global.events[event].isDone  {
            performSegueWithIdentifier("timerToPreviewSegue", sender: self)
        }
        
    }
    
    
    
}
