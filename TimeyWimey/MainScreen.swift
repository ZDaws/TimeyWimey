//
//  MainScreen.swift
//  TimeyWimey
//
//  Created by HOLM, JOEL on 1/19/16.
//  Copyright © 2016 Frands. All rights reserved.
//

import UIKit
import MessageUI

class MainScreen: UIViewController, UITableViewDataSource, UITableViewDelegate, MFMailComposeViewControllerDelegate {
    
    //Represents the number of current events
    var rows:Int = 0
    //The alert that is shown when the user presses the addEvent button
    var alert = UIAlertController()
    //Our tableview
    @IBOutlet weak var eventsTableView: UITableView!
    
    override func viewDidLoad() {
        
        //Set current # of rows to the number of current events
        rows = Global.events.count
        
    }
    
    /* Table Cell Function
    * This returns what will be in each individual table cell.   The row is indicated by indexPath.row.
    * We need to display the name of the event and color of the cell.
    * Each cell is 80 pixels tall
    */
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = eventsTableView.dequeueReusableCellWithIdentifier("prototype1", forIndexPath: indexPath)
        
        //just a test what prints on each cell
        cell.textLabel?.text = Global.events[indexPath.row].EventName
        cell.textLabel?.font = UIFont(name: (cell.textLabel?.font.fontName)!, size: 50)
        return cell
    }
    
    
    /* Table Rows
    * This returns the number of rows in our table.
    * We need to return the number of events that we currently have in our event object array
    * (events.count)
    */
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        
        //return Global.events.count
        return rows
    }
    
    
    /* Add Event Bar Button
    * This function is called when the user presses the add event button.  It needs to be connected to the UIBarButton on
    * the navigation bar.
    * Make a popup window appear and display the option to create a relay or open event
    * If open event is picked append a new open event to the global events array
    * If relay event is picked append a new relay event to the global events array
    * Then segue to the save screen and append a relay or open event object to our event array
    */
    
    //dismiss the alert if the user click anywhere except the buttons
    func alertClose(gesture: UITapGestureRecognizer) {
        alert.dismissViewControllerAnimated(true, completion: nil)
    }
    
    @IBAction func addEvent(sender: UIBarButtonItem) {
        //Create alert for adding events
        //Alert contains two buttons. One for open events and one for relays
        let openText = "Open"
        let relayText = "Relay"
        alert = UIAlertController(title: "Select an Event", message: "", preferredStyle: UIAlertControllerStyle.Alert)
        
        let openButton = UIAlertAction(title: openText, style: UIAlertActionStyle.Default, handler: {
            action in
            Global.events.append(Event(EventName: "New Event", isOpen: true))
            Global.currentEvent = self.rows
            self.performSegueWithIdentifier("addNewEventSegue", sender: self)
        })
        alert.addAction(openButton)
        let relayButton = UIAlertAction(title: relayText, style: UIAlertActionStyle.Default, handler: {
            action in
            Global.events.append(Event(EventName: "New Event", isOpen: false))
            Global.currentEvent = self.rows
            self.performSegueWithIdentifier("addNewEventSegue", sender: self)
        })
        alert.addAction(relayButton)
        
        //Add gesture recognizer for alert ViewController when adding an event while presenting alert
        self.presentViewController(self.alert, animated: true, completion:
            {
            self.alert.view.superview?.userInteractionEnabled = true
            self.alert.view.superview?.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(self.alertClose(_:))))
        }
        )
    }
    
    //start of zachs exporting code
    
    /* Export Bar Button
     * Export all the files
     * Take a for loop through all the events
     * Pull out each Runner and organize their times and names into a single string
     * add up all the Runner’s strings into one single string and export to google docs
     */
    @IBAction func export(sender: UIBarButtonItem) {
        
        
        // If the view controller can send the email.
        // This will show an email-style popup that allows you to enter
        // Who to send the email to, the subject, the cc's and the message.
        // As the .CSV is already attached, you can simply add an email
        // and press send.
        
        
        //check if there even events to export
        if Global.events.count > 0 {
            let emailViewController = configuredMailComposeViewController()
            if MFMailComposeViewController.canSendMail() {
                self.presentViewController(emailViewController, animated: true, completion: nil)
            }
        }
    }
    
    //should dismiss the view controller for email once something is sent or cancelled
    func mailComposeController(controller: MFMailComposeViewController, didFinishWithResult result: MFMailComposeResult, error: NSError?) {
        controller.dismissViewControllerAnimated(true, completion: nil)
    }
    
    //variables necessary to createFile()
    let fileName = "Events.csv"
    let StartString = "Event Name, Name,End Time,Splits\n"
    let tmpDir: NSString = NSTemporaryDirectory()
    
    //configures the email capabilites and is called in the main export function
    func configuredMailComposeViewController() -> MFMailComposeViewController {
        
        var Contents = StartString
        
        //need to add block if no events are made if i == 0 ... -- done
        
        if Global.events.count > 0 {
            
            //for loops - (event  ( runner ( name and endtime and (laps) ))
            
            for i in 0  ..< Global.events.count  {
                
                for c in 0  ..< Global.events[i].RegisterArray.count  {
                    
                    Contents += Global.events[i].EventName + ","
                    Contents += Global.events[i].RegisterArray[c].name + ","
                    Contents += Global.events[i].RegisterArray[c].endTime + ","
                    
                    //check if there are laps and if not will add a line break after endTime
                    if Global.events[i].RegisterArray[c].laps.count > 0  {
                        
                        for d in 0  ..< Global.events[i].RegisterArray[c].laps.count  {
                            
                            if d == (Global.events[i].RegisterArray[c].laps.count - 1) {
                                Contents += Global.events[i].RegisterArray[c].laps[d] + "\n"
                            }
                            else {
                                Contents += Global.events[i].RegisterArray[c].laps[d] + ","
                            }
                            
                        }
                    }
                    else {
                        Contents += "\n"
                    }
                }
                
                if Global.events[i].isOpen == false {
                        
                        Contents += Global.events[i].EventName + ",," + Global.events[i].finalTime + "\n"
                        
                        
                }
                Contents += "\n"    
                
                
            }
            
            
        }
        
        print(Contents)
        
        let path = tmpDir.stringByAppendingPathComponent(fileName)
        
        
        do {
            try Contents.writeToFile(path, atomically: true, encoding: NSUTF8StringEncoding)
            print("File Events.csv created at tmp directory")
        } catch {
            
            print("Failed to create file")
            print("\(error)")
        }
        
        
        let emailController = MFMailComposeViewController()
        emailController.mailComposeDelegate = self
        emailController.setSubject("CSV File")
        emailController.setMessageBody("", isHTML: false)
        
        // Attaching the .CSV file to the email.
        
        emailController.addAttachmentData(NSData(contentsOfFile: path)!, mimeType: "text/csv", fileName: "Events.csv")
        
        
        
        return emailController
    }
    
    //end of zachs email code
    
    
    
    /* Delete All Bar Button
    * Remove all events from the event object
    * Have a popup window that asks the user if they are sure they want to delete all events
    */
    let alertTitle2 = "Are you sure you want to delete all events?"
    let message2 = "All ongoing events will be stopped"
    let okText = "OK"
    let cancelText = "Cancel"
    
    
    @IBAction func deleteAll(sender: UIBarButtonItem) {
        let alert = UIAlertController(title: alertTitle2, message: message2, preferredStyle: UIAlertControllerStyle.Alert)
        let cancelButton = UIAlertAction(title: cancelText, style: UIAlertActionStyle.Cancel, handler: nil) //cancels
        alert.addAction(cancelButton)
        let okButton = UIAlertAction(title: okText, style: UIAlertActionStyle.Destructive) {
            UIAlertAction in
            //stop the timer for each runner incase the user decides to delete all events while an event is still running
            for i in 0  ..< Global.events.count  {
                Global.events[i].timer.invalidate()
            }
            Global.currentEvent = 0
            Global.events = []
            self.rows = 0
            self.eventsTableView.reloadData()

        }//calls
        alert.addAction(okButton)
        
        presentViewController(alert, animated: true, completion: nil)
    }
    
    /* Editable table
    * Makes table editable, return true
    */
    func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        return true
    }
    
    /* Swipe to delete
    * Create an editing style that allows the user to swipe and delete an event
    */
    func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == UITableViewCellEditingStyle.Delete {
            Global.events.removeAtIndex(indexPath.row)
            rows = rows - 1 //rows must be reset so that the path stays the same in eventsTableView
            eventsTableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: UITableViewRowAnimation.Automatic)
        }
    }

    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        Global.currentEvent = indexPath.row
        self.performSegueWithIdentifier("mainToTimerSegue", sender: self)
    }
    
}
