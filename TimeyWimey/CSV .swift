//
//  CSV .swift
//  TimeyWimey
//
//  Created by CHERMAK, ZACHARY on 2/17/16.
//  Copyright © 2016 Frands. All rights reserved.
//

import Foundation
import UIKit


class CSV {
    
    
    let fileName = "Events.csv"
    let StartString = "Name,End Time,Lap\n,"
    let tmpDir: NSString = NSTemporaryDirectory() as String
    let contentsOfFile: String
    
    
    func createFile() {
        
       let path = tmpDir.stringByAppendingPathComponent(fileName)

        
        do {
            try contentsOfFile.writeToFile(path, atomically: true, encoding: NSUTF8StringEncoding)
            print("File Events.csv created at tmp directory")
        } catch {
            
            print("Failed to create file")
            print("\(error)")
        }
        
    
    }
    
    func fill() {
        
    }
    
    
    
}