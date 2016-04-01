//
//  EditScreen.swift
//  TimeyWimey
//
//  Created by KUSKE, JOEL on 2/1/16.
//  Copyright © 2016 Frands. All rights reserved.
//

import UIKit

class EditScreen: UIViewController {
    
    
    //Variables for finding the screen size
    var screenSize: CGRect = UIScreen.mainScreen().bounds
    var width: CGFloat = 0.0
    var height: CGFloat = 0.0
    //var currentEvent: Int
    var myTextFields: [CustomTextField] = []
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
    //Max characters in the textfield
    var maxChar = Int(10)
    
    
    /* Load View
    * The area in which the labels and buttons for runners will go will be in the bottom of the screen
    * At the top of the view place a text field with placeholder text of that events name
    * Each runner will have a place holder text of their name
    */
    
    override func viewDidLoad() {
        
        //If open add new runners to the register array with names of "New Runner" until there are 10 runnners
        if Global.events[event].isOpen && Global.events[event].isDone == false {
            while Global.events[event].RegisterArray.count < 10    {
                Global.events[event].RegisterArray.append(Runner(n: "New Runner"))
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
            if Global.events[event].isDone == false {
                //Set number of runners to 10 - 1
                numRun = 9
            } else {
                numRun = Global.events[event].RegisterArray.count - 1
            }
        }
        else    {
            //Set number of runners to 4 - 1
            numRun = 3
            
        }
        //Background layer for runners
        let background = UILabel(frame: CGRect(x: Horz - 1, y: eventH + NavBar + (Vert * 2) - 0.5, width: width - (2 * Horz) + 2, height: (labelH * CGFloat(numRun + 1)) + 1))
        background.backgroundColor = UIColor.blackColor()
        self.view.addSubview(background)
      
        //Textfields
        for x in 0...numRun {
                
                frm = CGRect(x: Horz, y: (NavBar + (Vert * 2) + eventH) + (labelH * CGFloat(x)) + 1, width: width - 2 * Horz, height: labelH - 2)
            
                myTextFields.append(CustomTextField(frame: frm, x))
                myTextFields[x].font = UIFont(name: "Courier New", size: (labelH * 2) / 3)
                myTextFields[x].text = Global.events[event].RegisterArray[x].name
                myTextFields[x].clearsOnBeginEditing = true
                myTextFields[x].addTarget(self, action: "textFieldUnselected:", forControlEvents: .EditingDidEnd)
            
            
                if x % 2 == 0   {
                    myTextFields[x].backgroundColor = UIColor(red: 0, green: 0.4157, blue: 1, alpha: 1.0)
                } else {
                    myTextFields[x].backgroundColor = UIColor(red: 0, green: 0.898, blue: 0.0118, alpha: 1.0)
                }
            
                self.view.addSubview(myTextFields[x])
        
        }
        
        
        
        //Create the event name textfield
        frm = CGRect(x: width / 4 , y: NavBar + Vert, width: eventW, height: eventH)
        eventTextField = CustomTextField(frame: frm , 20)
        eventTextField.font = UIFont(name: "Courier New", size: (eventH * 2) / 3)
        eventTextField.text = Global.events[event].EventName
        eventTextField.textAlignment = .Center
        eventTextField.backgroundColor = UIColor.blackColor()
        if Global.events[event].EventName == "New Event" || Global.events[event].EventName == ""    {
            eventTextField.textColor = UIColor.grayColor()
            eventTextField.text = "New Event"
        } else {
            eventTextField.textColor = UIColor.whiteColor()
        }
        eventTextField.layer.cornerRadius = 20.0
        eventTextField.clipsToBounds = true
        if Global.events[event].EventName == "New Event"    {
            eventTextField.clearsOnBeginEditing = true
        }
        eventTextField.addTarget(self, action: "eventTextFieldUnselected:", forControlEvents: .EditingDidBegin)
        self.view.addSubview(eventTextField)
        
        
        
        
        
    }
    //End of viewDidLoad()
    
    
    
    
    
    
    func eventTextFieldUnselected(sender: UITextField)  {
        
        sender.clearsOnBeginEditing = false
        sender.textColor = UIColor.whiteColor()
        
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
        
        if Global.events[event].isOpen && Global.events[event].isDone == false {
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
