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
    
    
    
    @IBOutlet weak var testLabel: UILabel!
    
    
    
    
    
    /* Load View
    * The area in which the labels and buttons for runners will go will be in the bottom of the screen
    * At the top of the view place a text field with placeholder text of that events name
    * Each runner will have a place holder text of their name
    */
    
    override func viewDidLoad() {
        //Set the screen size using variables screenSize, width, height
        width = screenSize.width
        height = screenSize.height
        
        testLabel.text = "\(Global.currentEvent)"
        
        //Create the event name textfield
        
        frm = CGRect(x: width / 4 , y: NavBar + Vert, width: eventW, height: eventH)
        eventTextField = CustomTextField(frame: frm , 20)
        eventTextField.font = UIFont(name: eventTextField.font!.fontName, size: (eventH * 2) / 3)
        eventTextField.text = Global.events[event].EventName
        eventLabel = UILabel(frame: frm)
        eventLabel.backgroundColor = UIColor.grayColor()
        self.view.addSubview(eventLabel)
        self.view.addSubview(eventTextField)
        
        
        
        //If open event
        //{
        /*
        * Within the area laid out create 10 text fields with placeholder text of that runners
        * name.  Every other text field will be light blue and green
        */
        //}
        //else relay event
        //{
        /*
        * Within the area laid out create 4 text fields with placeholder text of that runner’s
        * name.  Every other text field will be light blue and green
        */
        //}
        
        
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
    
        //Save text in textfields to global data
        for x in 0...numRun {
            Global.events[event].RegisterArray[x].name = myTextFields[x].text!
            
        }
        
        
        //save event name to global data
        Global.events[event].EventName = eventTextField.text!
        
        
        performSegueWithIdentifier("saveToTimerSegue", sender: self)
    
    
    }
    
    
    
    
    
    
    
    
    
    
    
    
    
    

}
