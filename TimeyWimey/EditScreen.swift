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
    
    
    
    @IBOutlet weak var testLabel: UILabel!
    
    
    
    
    
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
        
        testLabel.text = "\(Global.currentEvent)"
        
        
        
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

    
    
    
    
    

}
