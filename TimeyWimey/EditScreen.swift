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
    
    
    
    
    /* Load View
    * The area in which the labels and buttons for runners will go will be in the bottom of the screen
    * The margin will be around 1/16 of the screen width, with an extra 16th at the top for the name
    * of the event
    * At the top of the view place a text field with placeholder text “Event Name”
    */
    
    override func viewDidLoad() {
        //Set the screen size using variables screenSize, width, height
        width = screenSize.width
        height = screenSize.height
        
        
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
                labelH = (height - (eventH + NavBar + Vert * 2)) / 10
                frm = CGRect(x: Horz, y: (NavBar + Vert + eventH) + labelH * CGFloat(x), width: width - 2 * Horz, height: labelH)
                myLabels.append(UILabel(frame: frm ))
                if x % 2 == 0   {
                    myLabels[x].backgroundColor = UIColor.blueColor()
                } else {
                    myLabels[x].backgroundColor = UIColor.greenColor()
                }
                self.view.addSubview(myLabels[x])
            
                myTextFields.append(CustomTextField(frame: frm, x))
                myTextFields[x].font = UIFont(name: myTextFields[x].font!.fontName, size: labelH)
                myTextFields[x].text = Global.events[event].RegisterArray[x].name
                myTextFields[x].textAlignment = NSTextAlignment.Center
            
                self.view.addSubview(myTextFields[x])
        
        }
        
        //Create the event name textfield
        //var eventTextField = CustomTextField(frame: <#T##CGRect#>, 0)
        
        
        
        
        
        
        
    }
    
    
    /*Text field Unselected
    * This function will be called when the user unselects a certain text field
    * the text inside should be saved to that runner's name.  If “New Runner” or “” is in the text field
    * save that runner’s name as nil.  To link each text field to this function we need to call
    * .addTarget(self, action: "textFieldUnselected:", forControlEvents: .EditingDidEnd)
    *To find which textField was selected create a CustomTextField class and add one instance variable that represents which
    * text field was selected.
    * Then use sender.num to select where the text will be saved
    * (ex: Global.events[currentEvent].runners[sender.num] = sender.text
    */
    
    func textFieldUnselected(sender: UITextField) {
        
        
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

    
    
    
    
    @IBAction func saveButton(sender: UIBarButtonItem) {
    
        
        performSegueWithIdentifier("saveToTimerSegue", sender: self)
    
    
    
    
    }
    
    
    
    
    
    
    
    
    
    
    
    
    
    

}
