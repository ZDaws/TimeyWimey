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
    
    
    
    
    //Our tableview
    @IBOutlet weak var eventsTableView: UITableView!
    
    
    
    
    
    
    override func viewDidLoad() {
        
        //Set current # of rows to the number of current events
        rows = Global.events.count
        print("\(Global.events.count)")
        
        
        
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
    
    var alertTitle1 = "Select an Event"
    var message1 = ""
    let openText = "Open"
    let relayText = "Relay"
    
    @IBAction func addEvent(sender: UIBarButtonItem) {
        let alert = UIAlertController(title: alertTitle1, message: message1, preferredStyle: UIAlertControllerStyle.Alert)
        let openButton = UIAlertAction(title: openText, style: UIAlertActionStyle.Default, handler: {
            action in
            Global.events.append(Event(EventName: "New Event", RegisterArray: [], typeOpen: true, isTiming: false, isDone: false, finalTime: "00:00:00", displayTimeLabel: UILabel()))
            Global.currentEvent = self.rows
            self.performSegueWithIdentifier("addNewEventSegue", sender: self)
        })
        alert.addAction(openButton)
        let relayButton = UIAlertAction(title: relayText, style: UIAlertActionStyle.Default, handler: {
            action in
            Global.events.append(Event(EventName: "New Event", RegisterArray: [], typeOpen: false, isTiming: false, isDone: false, finalTime: "00:00:00", displayTimeLabel: UILabel()))
            Global.currentEvent = self.rows
            self.performSegueWithIdentifier("addNewEventSegue", sender: self)
        })
        alert.addAction(relayButton)
        
        presentViewController(alert, animated: true, completion: nil)
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
            
            // Global (  events[]  (  RegisterArray[] ( runner instance varibales) )  )
            // Global.event[i].RegisterArray[c].
            
            
            
            
            // Done
            for var i = 0 ; i < Global.events.count ; i++ {
                
                for var c = 0 ; c < Global.events[i].RegisterArray.count ; c++ {
                    
                    Contents += Global.events[i].EventName + ","
                    Contents += Global.events[i].RegisterArray[c].name + ","
                    Contents += Global.events[i].RegisterArray[c].endTime + ","
                    
                    Global.events[i].RegisterArray[c].lapDur()
                    
                    //check if there are laps and if not will add a line break after endTime
                    if Global.events[i].RegisterArray[c].laps.count > 0  {
                        
                        for var d = 0 ; d < Global.events[i].RegisterArray[c].laps.count ; d++ {
                            
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
                    
                    if Global.events[i].isOpen == false {
                        
                        Contents += Global.events[i].EventName + ",," + Global.events[i].finalTime + "\n"
                        
                        
                    }
                    
                }
                
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
            for var i = 0 ; i < Global.events.count ; i++ {
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
