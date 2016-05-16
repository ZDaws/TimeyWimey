//
//  Preview.swift
//  TimeyWimey
//
//  Created by HOLM, JOEL on 4/15/16.
//  Copyright © 2016 Frands. All rights reserved.
//

import UIKit

class Preview: UIViewController {

    //Screen sizing variables
    let event: Int = Global.currentEvent
    var screenSize: CGRect = UIScreen.mainScreen().bounds
    var width: CGFloat = 0.0
    var height: CGFloat = 0.0
    //Spacing between borders and labels
    var space: CGFloat = 0
    /* Individual letter length
    * This is the key to laying out the screen
    * We use this * the number of characters before a label to place the label in the correct spot
    */
    var charL: CGFloat = 0.0
    //Label Height
    var labelH: CGFloat = 0.0
    //Int representing the max number of laps by any runner in this event
    var maxLaps: Int = 0
    //This is 7 because if runners names are very small then have the size be 7 because of the "Runner" top label
    var maxName: Int = 7
    var navBar: CGFloat = 60.0
    var lapsForRunner: Int = 0
    
    @IBOutlet weak var scrollView: UIScrollView!
    
    @IBOutlet weak var navTitle: UINavigationItem!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        navTitle.title = Global.events[event].EventName
        
        width = screenSize.width
        height = screenSize.height
        space = height / 12
        labelH = (height - (navBar + 2 * space)) / 11
        
        
        //Just like in timer screen but this takes the labelH and finds how long each individual character should be
        charL = labelH * (3 / 4) * (31.0 / 50.0)
        

        //Find max num of lap times using maxLapNum and the maxChacters in the name
        for runner in Global.events[event].RegisterArray	{
            if maxLaps < runner.laps.count	{
                maxLaps = runner.laps.count
            }
            if maxName < runner.name.characters.count	{
                maxName = runner.name.characters.count
            }
        }
        //Add one to that so there is a bit of spaceing
        maxName = maxName + 1
        
        
        //Set scroll width
        scrollView.contentSize.width = (charL * (CGFloat(maxName) + CGFloat(maxLaps) * 9 + 11)) + space * 2
        
        
        //Layout Screen
        
        //Layout black background
        var label  = UILabel(frame: CGRect(x: space - 1, y: navBar + space - 1, width: charL * (CGFloat(maxName) + CGFloat(maxLaps) * 9 + 11) + 1, height: labelH * CGFloat(Global.events[event].RegisterArray.count + 1) + 1))
        label.backgroundColor = .blackColor()
        label.font = UIFont(name: "Courier New", size: (labelH * 3) / 4)
        label.textAlignment = .Center
        self.scrollView.addSubview(label)
        
        //Layout the top boxes |Runners|Final Times|Lap #1|Lap #2|...|Lap #maxLapNum|
        label = UILabel(frame: CGRect(x: space , y: navBar + space, width: CGFloat(maxName) * charL - 1, height: labelH - 1))
        label.text = "Runner"
        label.backgroundColor = .whiteColor()
        label.font = UIFont(name: "Courier New", size: (labelH * 3) / 4)
        label.textAlignment = .Center
        self.scrollView.addSubview(label)
        
        //9 represents the string 00:00:00  so 9 is one more than the 8 chars (for exrta space)
        label = UILabel(frame: CGRect(x: space + CGFloat(maxName) * charL, y: navBar + space, width: (11 * charL) - 1, height: labelH - 1))
        label.text = "Final Time"
        label.backgroundColor = .whiteColor()
        label.font = UIFont(name: "Courier New", size: (labelH * 3) / 4)
        label.textAlignment = .Center
        self.scrollView.addSubview(label)
        
        //Lay out the lap label titles
        for i in 0  ..< maxLaps    {
            label = UILabel(frame: CGRect(x: space + charL * (CGFloat(maxName) + CGFloat(i) * 9 + 11) , y: navBar + space, width: (9 * charL) - 1, height: labelH - 1))
            label.text = "Lap #\(i + 1)"
            label.backgroundColor = .whiteColor()
            label.font = UIFont(name: "Courier New", size: (labelH * 3) / 4)
            label.textAlignment = .Center
            self.scrollView.addSubview(label)
        }
        
        
        //for loop through runners
        for i in 0  ..< Global.events[event].RegisterArray.count  {
            //layout runners
            label = UILabel(frame: CGRect(x: space , y: navBar + space + labelH * CGFloat(i + 1), width: CGFloat(maxName) * charL - 1, height: labelH - 1))
            label.text = Global.events[event].RegisterArray[i].name
            label.backgroundColor = .whiteColor()
            label.font = UIFont(name: "Courier New", size: (labelH * 3) / 4)
            label.textAlignment = .Center
            self.scrollView.addSubview(label)
            
            //Layout final times
            label = UILabel(frame: CGRect(x: space + CGFloat(maxName) * charL, y: navBar + space + labelH * CGFloat(i + 1), width: (11 * charL) - 1, height: labelH - 1))
            label.text = Global.events[event].RegisterArray[i].endTime
            label.backgroundColor = .whiteColor()
            label.font = UIFont(name: "Courier New", size: (labelH * 3) / 4)
            label.textAlignment = .Center
            self.scrollView.addSubview(label)
            
            //Layout all laps for this runnner even if it is under max laps
            lapsForRunner = Global.events[event].RegisterArray[i].laps.count
            for k in 0 ..< lapsForRunner    {
                label = UILabel(frame: CGRect(x: space + charL * (CGFloat(maxName) + CGFloat(k) * 9 + 11) , y: navBar + space + labelH * CGFloat(i + 1), width: (9 * charL) - 1, height: labelH - 1))
                label.text = Global.events[event].RegisterArray[i].laps[k]
                label.backgroundColor = .whiteColor()
                label.font = UIFont(name: "Courier New", size: (labelH * 3) / 4)
                label.textAlignment = .Center
                self.scrollView.addSubview(label)
            }
            //If there are missing labels inbetween lapArray.count and maxLaps fill in blank spaces with -
            for k in lapsForRunner ..< maxLaps    {
                label = UILabel(frame: CGRect(x: space + charL * (CGFloat(maxName) + CGFloat(k) * 9 + 11) , y: navBar + space + labelH * CGFloat(i + 1), width: (9 * charL) - 1, height: labelH - 1))
                label.font = UIFont(name: "Courier New", size: (labelH * 3) / 4)
                label.textAlignment = .Center
                label.text = "-"
                label.backgroundColor = .whiteColor()
                self.scrollView.addSubview(label)
            }
            
        }
        
        //If the event is a relay place a final relay time label at the bottom
        if Global.events[event].isOpen == false {
            
            label = UILabel(frame: CGRect(x: space , y: navBar + space + labelH * CGFloat(Global.events[event].RegisterArray.count + 2), width: 11 * charL - 1, height: labelH - 1))
            label.text = "Total Time"
            label.backgroundColor = .whiteColor()
            label.font = UIFont(name: "Courier New", size: (labelH * 3) / 4)
            label.textAlignment = .Center
            self.scrollView.addSubview(label)
            
            label = UILabel(frame: CGRect(x: space + 11 * charL , y: navBar + space + labelH * CGFloat(Global.events[event].RegisterArray.count + 2), width: 9 * charL - 1, height: labelH - 1))
            label.text = Global.events[event].finalTime
            label.backgroundColor = .whiteColor()
            label.font = UIFont(name: "Courier New", size: (labelH * 3) / 4)
            label.textAlignment = .Center
            self.scrollView.addSubview(label)
            

        }
        
 
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
    //Enables and disables scrollview
    //I don't think we need this but I'm just keeping it just in case
//    func stop(sender: UIButton) {
//        if self.scrollView.scrollEnabled {
//            self.scrollView.scrollEnabled = false
//        } else {
//            self.scrollView.scrollEnabled = true
//        }
//    }
    
    
    
   
    
    
    
    @IBAction func backButton(sender: UIBarButtonItem) {
        
        
        performSegueWithIdentifier("previewToTimerSegue", sender: self)
        
    }
    
    
    
    
    
}
