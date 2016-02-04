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
    var myTextFields: [UITextField] = []
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
    var frame = CGRect()
    
    
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
        
        
        
        if Global.events[event].isOpen == true  {
            //create 10 labels and textfields
            for x in 0...9 {
                labelH = (height - (NavBar + Vert * 2)) / 10
                
                myLabels.append(UILabel(frame: CGRect(x: Horz, y: (NavBar + Vert) + labelH * CGFloat(x), width: width - 2 * Horz, height: labelH)))
                if x % 2 == 0   {
                    myLabels[x].backgroundColor = UIColor.blueColor()
                } else {
                    myLabels[x].backgroundColor = UIColor.greenColor()
                }
                self.view.addSubview(myLabels[x])
                
                
                
                
            
            }
 
            
        }
        else    {
            //Create 4 labels and text fields
            
            
            
            
            
            
            
        }
        
        
        
        
        
        
        
        
        
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
