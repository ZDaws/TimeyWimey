//
//  AppDelegate.swift
//  TimeyWimey
//
//  Created by DAWSON, ZACHARIAH on 1/19/16.
//  Copyright © 2016 Frands. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        //Override point for customization after application launch.
        if NSKeyedUnarchiver.unarchiveObjectWithFile(Event.ArchiveURL.path!) as? [Event] != nil {
            Global.events = (NSKeyedUnarchiver.unarchiveObjectWithFile(Event.ArchiveURL.path!) as? [Event])!
        }
        return true
    }   

    func applicationWillResignActive(application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types
        // of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the 
        // application and it begins the transition to the background state. Use this method to pause ongoing tasks,
        // disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
        
        let isSuccessfulSave = NSKeyedArchiver.archiveRootObject(Global.events, toFile: Event.ArchiveURL.path!)
        if !isSuccessfulSave {
          print("Failed to save events...")
        }
    }


}

