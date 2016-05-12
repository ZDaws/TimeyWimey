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
    //Text fields used for the names of the runners
    var myTextFields: [CustomTextField] = []
    //Navigaiton bar height
    let NavBar: CGFloat = 60
    //horizontal spacing between and text fields and the edge of the screen
    let Horz: CGFloat = 20
    //vertical spacing between nav bar and text fields
    let Vert: CGFloat = 20
    //current event
    let event: Int = Global.currentEvent
    //This represents the height of the textfields
    var labelH: CGFloat = 0
    //Useable frame
    var frm = CGRect()
    //Variable to represent the number of runners 4 for relay or 10 for open
    var numRun: Int = 0
    //Height of Event name textfield
    var eventH: CGFloat = 0
    //Length of the event textfield
    var eventW: CGFloat = 0
    //Event textfield
    var eventTextField = CustomTextField(frame: CGRect(), 0)
    //Max characters in the textfield
    var maxChar = Int(30)
    //The scrollview
    @IBOutlet weak var scrollView: UIScrollView!
    //To get rid of keyboard
    var tap = UITapGestureRecognizer()
    //Current textfield selected 0 = event name then 1-10 is each textfield
    var currTextF: Int = 0
    
    /* Load View
    * The area in which the labels and buttons for runners will go will be in the bottom of the screen
    * At the top of the view place a text field with placeholder text of that events name
    * Each runner will have a place holder text of their name
    */
    override func viewDidLoad() {
        
        //This tap gesture allows the keyboard to be deselected when a user taps outside the textfield
        tap = UITapGestureRecognizer(target: self, action: #selector(EditScreen.dismissKeyboard))
        view.addGestureRecognizer(tap)
        
        
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
        
        //Set the scroll view length a bit larger than the regular view so the keyboard can't cover up the runners
        if Global.events[event].isOpen  {
            scrollView.contentSize.height = 3 * height / 2
        } else  {
            //not as much for relay though
            scrollView.contentSize.height = 15 * height / 14
        }
        //Scroll view should only work when the keyboard is up
        scrollView.scrollEnabled = false
        
        //Find the max characters can fit on the next screen  (Doesn't work because of different Horz and Verts)
        //maxChar = Int(((width - (Horz * 2)) / ((labelH * 2 * 3) / (3 * 5))))
        
        //Set how many runners there should be 4 for relay and 10 for open
        if Global.events[event].isOpen == true  {
            if Global.events[event].isDone == false {
                //Set number of runners to 10 - 1 (for for-loop ease)
                numRun = 9
            } else {
                //If the event is done don't allow the user to add another runner
                numRun = Global.events[event].RegisterArray.count - 1
            }
        }
        else    {
            //Set number of runners to 4 - 1 (for for-loop ease)
            numRun = 3
            
        }
        
        //Black background layer for runners
        let background = UILabel(frame: CGRect(x: Horz - 1, y: eventH + NavBar + (Vert * 2) - 0.5, width: width - (2 * Horz) + 2, height: (labelH * CGFloat(numRun + 1)) + 1))
        background.backgroundColor = UIColor.blackColor()
        self.scrollView.addSubview(background)
      
        //Textfields
        for x in 0...numRun {
            
            
                frm = CGRect(x: Horz, y: (NavBar + (Vert * 2) + eventH) + (labelH * CGFloat(x)) + 1, width: width - 2 * Horz, height: labelH - 2)
            
                myTextFields.append(CustomTextField(frame: frm, x))
                myTextFields[x].font = UIFont(name: "Courier New", size: (labelH * 2) / 3)
                myTextFields[x].text = Global.events[event].RegisterArray[x].name
                if myTextFields[x].text == "New Runner" {
                    myTextFields[x].clearsOnBeginEditing = true
                } else{
                    myTextFields[x].clearsOnBeginEditing = false
                }
            
                myTextFields[x].num = x
                if myTextFields[x].text ==  "New Runner"  {
                    myTextFields[x].textColor = UIColor.darkGrayColor()
                } else {
                    myTextFields[x].textColor = UIColor.blackColor()
                }
                myTextFields[x].addTarget(self, action: #selector(EditScreen.textFieldUnselected(_:)), forControlEvents: .EditingDidEnd)
                myTextFields[x].addTarget(self, action: #selector(EditScreen.textFieldSelected(_:)), forControlEvents: .EditingDidBegin)
            
                //Setting colors
                if x % 2 == 0   {
                    myTextFields[x].backgroundColor = UIColor(red: 0, green: 0.4157, blue: 1, alpha: 1.0)
                } else {
                    myTextFields[x].backgroundColor = UIColor(red: 0, green: 0.898, blue: 0.0118, alpha: 1.0)
                }
            
                self.scrollView.addSubview(myTextFields[x])
        
        }
        
        //Create the event name textfield
        frm = CGRect(x: width / 4 , y: NavBar + Vert, width: eventW, height: eventH)
        eventTextField = CustomTextField(frame: frm , 20)
        eventTextField.font = UIFont(name: "Courier New", size: (eventH * 2) / 3)
        eventTextField.text = Global.events[event].EventName
        eventTextField.textAlignment = .Center
        eventTextField.backgroundColor = UIColor.blackColor()
        //This code makes it so the textfield works with placeholder text the way we want
        if Global.events[event].EventName == "New Event"   {
            eventTextField.textColor = UIColor.grayColor()
            eventTextField.text = "New Event"
            eventTextField.clearsOnBeginEditing = true
        } else {
            eventTextField.textColor = UIColor.whiteColor()
            eventTextField.clearsOnBeginEditing = false
        }
        eventTextField.layer.cornerRadius = 20.0
        eventTextField.clipsToBounds = true
        eventTextField.addTarget(self, action: #selector(EditScreen.eventTextFieldSelected(_:)), forControlEvents: .EditingDidBegin)
        eventTextField.addTarget(self, action: #selector(EditScreen.eventTextFieldUnselected(_:)), forControlEvents: .EditingDidEnd)
        self.scrollView.addSubview(eventTextField)
        
    }
    //End of viewDidLoad()
    
    
    //Fires when the event text field is selected
    func eventTextFieldSelected(sender: UITextField)  {
        
        
        if sender.text != "New Event"   {
            sender.clearsOnBeginEditing = false
        } else {
            sender.text = ""
        }
        sender.textColor = UIColor.whiteColor()
        currTextF = 0
        
    }
    
    //Fires when the event text field is unselected
    func eventTextFieldUnselected(sender: UITextField)  {
        if sender.text == ""    {
            sender.text = "New Event"
            sender.textColor = UIColor.grayColor()
        }
        
    }

    //Fires when any runner textfield is selected
    func textFieldSelected(sender: CustomTextField) {
        scrollView.scrollEnabled = true
        currTextF = sender.num + 1
        sender.textColor = UIColor.blackColor()
    
    }
    
    //Fires when any runner textfield is unselected
    func textFieldUnselected(sender: UITextField) {
        scrollView.scrollEnabled = false
        scrollView.contentOffset = CGPoint(x: 0, y:0)
        
        if sender.text?.characters.count >= maxChar + 1  {
            while sender.text?.characters.count >= maxChar + 1 {
                sender.text!.removeAtIndex(sender.text!.endIndex.predecessor())
            }
        }
        
        if sender.text == "" || sender.text == "New Runner" {
            sender.text = "New Runner"
            sender.textColor = UIColor.darkGrayColor()
        } else {
            sender.clearsOnBeginEditing = false
        }
       
    }
    
    
    //Probalby don't need but test more
    /*Touch to remove keyboard
    * When the keyboard is up this function will be called when the user touches outside of the
    * keyboard and the keyboard will disappear.
    */
//    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?)
//    {
//        self.scrollView.endEditing(true)
//        super.touchesBegan(touches, withEvent: event )
//    }
    
    //Same thing idk if we need
    /* Return to remove keyboard
    * When the keyboard is up this function will be called when the user presses return
    * and the keyboard will disappear.
    */
//    func textFieldShouldReturn(textField: UITextField) -> Bool
//    {
//        
//        textField.resignFirstResponder()
//        return true
//        
//    }

    
    func dismissKeyboard()  {
        if currTextF == 0    {
            eventTextField.resignFirstResponder()
        } else {
            myTextFields[currTextF - 1].resignFirstResponder()
        }
        
    }
    
    
    
    
    
    
    /* Segue to timer
    * Before the segue each string in each text field will be saved into an array of runners
    * If open, remove a runner from the Register array is their name is "New Event" or ""
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
