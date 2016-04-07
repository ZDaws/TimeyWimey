//
//  EditScreen.swift
//  TimeyWimey
//
//  Created by KUSKE, JOEL on 2/1/16.
//  Copyright © 2016 Frands. All rights reserved.
//

import UIKit

class EditScreen: UIViewController{
    
    
    //Variables for finding the screen size
    var screenSize: CGRect = UIScreen.mainScreen().bounds
    var width: CGFloat = 0.0
    var height: CGFloat = 0.0
    //var currentEvent: Int
    var myTextFields: [CustomTextField] = []
    var myLabels: [UILabel] = []
    //Navigaiton bar height
    let NavBar: CGFloat = 60
    //horizontal spacing between nav bar and text fields
    let Horz: CGFloat = 20
    //vertical spacing between nav bar and text fields
    let Vert: CGFloat = 20
    //current event
    let event: Int = Global.currentEvent
    //label height
    var labelH: CGFloat = 0
    //Tiny spacing
    var space: CGFloat = 1
    //Useable frame
    var frm = CGRect()
    //Variable to represent the number of runners 4 for relay or 10 for open
    var numRun: Int = 0
    //Height of Event name
    var eventH: CGFloat = 0
    //Length of the event textfield
    var eventW: CGFloat = 0
    //Event textfield and label
    var eventTextField = CustomTextField(frame: CGRect(), 0)
    var eventLabel = UILabel()
    //Max characters in the textfield
    var maxChar = Int(10)
    
    
    /* Load View
    * The area in which the labels and buttons for runners will go will be in the bottom of the screen
    * At the top of the view place a text field with placeholder text of that events name
    * Each runner will have a place holder text of their name
    */
    
    override func viewDidLoad() {
        
        //If open add new runners to the register array with names of "New Runner" until there are 10 runnners
        if Global.events[event].isOpen {
            while Global.events[event].RegisterArray.count < 10    {
                Global.events[event].RegisterArray.append(Runner(n: "New Runner", endTime: "", lapArray: [], fLapArray: []))
            }

        }
        
     
        
        
        
        //Set the screen size using variables screenSize, width, height
        width = screenSize.width
        height = screenSize.height
        eventH = (height - NavBar) / 10
        eventW = width / 2
        labelH = (height - (eventH + NavBar + Vert * 3)) / 10
        
        
        //Find the max characters can fit on the next screen
        maxChar = Int(((width - (Horz * 2)) / ((labelH * 2 * 3) / (3 * 5))))
        
        
        
        //Create and display textfields with backgrounds
        if Global.events[event].isOpen == true  {
            //Set number of runners to 10 - 1
            numRun = 9
        }
        else    {
            //Set number of runners to 4 - 1
            numRun = 3
            
        }
        
        for x in 0...numRun {
                
                frm = CGRect(x: Horz, y: (NavBar + (Vert * 2) + eventH) + (labelH * CGFloat(x)), width: width - 2 * Horz, height: labelH)
                myLabels.append(UILabel(frame: frm ))
                if x % 2 == 0   {
                    myLabels[x].backgroundColor = UIColor.blueColor()
                } else {
                    myLabels[x].backgroundColor = UIColor.greenColor()
                }
                self.view.addSubview(myLabels[x])
            
                myTextFields.append(CustomTextField(frame: frm, x))
                myTextFields[x].font = UIFont(name: "Courier New", size: (labelH * 2) / 3)
                myTextFields[x].text = Global.events[event].RegisterArray[x].name
                myTextFields[x].clearsOnBeginEditing = true
                myTextFields[x].addTarget(self, action: "textFieldUnselected:", forControlEvents: .EditingDidEnd)
            
                self.view.addSubview(myTextFields[x])
        
        }
        
        //Create the event name textfield
        
        frm = CGRect(x: width / 4 , y: NavBar + Vert, width: eventW, height: eventH)
        eventTextField = CustomTextField(frame: frm , 20)
        eventTextField.font = UIFont(name: "Courier New", size: (eventH * 2) / 3)
        eventTextField.text = Global.events[event].EventName
        eventLabel = UILabel(frame: frm)
        eventLabel.backgroundColor = UIColor.grayColor()
        self.view.addSubview(eventLabel)
        self.view.addSubview(eventTextField)
        
        
        
        
        
    }
    
    
    /*  Text field Unselected
    * This function will be called when the user unselects a certain text field
    * If the text extends past the text field length cut the excess string off
    */
    
    func textFieldUnselected(sender: UITextField) {
        
        if sender.text?.characters.count >= maxChar + 1  {
            while sender.text?.characters.count >= maxChar + 1 {
                sender.text!.removeAtIndex(sender.text!.endIndex.predecessor())
            }
        }
        
        
    }
    
    
    
    
    
    
    
    
    /*Touch to remove keyboard
    * When the keyboard is up this function will be called when the user touches outside of the
    * keyboard and the keyboard will disappear.
    */
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?)
    {
        self.view.endEditing(true)
        super.touchesBegan(touches, withEvent: event )
    }
    
    
    
    
    /* Return to remove keyboard
    * When the keyboard is up this function will be called when the user presses return
    * and the keyboard will disappear.
    */
    func textFieldShouldReturn(textField: UITextField) -> Bool
    {
        //myTextFields[].resignFirstResponder()
        return true
    }

    
    
    /* Segue to timer
    * Before the segue each string in each text field will be saved into an array of runners
    * If open remove a runner from the Register array is their name is "New Event" or ""
    */
    
    var y: Int = 9
    
    @IBAction func saveButton(sender: UIBarButtonItem) {
    
        y = numRun
        
        //Save text in textfields to global data
        for x in 0...numRun {
            Global.events[event].RegisterArray[x].name = myTextFields[x].text!
        }
        //If a new runner hasn't been put in, remove that runner
        
        if Global.events[event].isOpen {
            while y >= 0    {
            
                if  Global.events[event].RegisterArray[y].name == "" ||
                    Global.events[event].RegisterArray[y].name == "New Runner"    {
                        Global.events[event].RegisterArray.removeAtIndex(y)
                        
                }
                y = y - 1
            }
        }
        
        //save event name to global data
        Global.events[event].EventName = eventTextField.text!
        
        
        performSegueWithIdentifier("saveToTimerSegue", sender: self)
    
    
    }
    
    
    
    
    
    
    
    
    
    
    
    
    
    

}
