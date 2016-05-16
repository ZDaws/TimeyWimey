//
//  CustomButton.swift
//  TimeyWimey
//
//  Created by HOLM, JOEL on 2/19/16.
//  Copyright © 2016 Frands. All rights reserved.
//

import UIKit


/* This class represents a UIButton
* It is of the type UIButton so it works exactly like a UIButton
* The only difference is that it has some extra instance variables
*/
class CustomButton: UIButton {
    
    //Instance Variables
    //Some of these instance variables were probably not used but put in just in case
    //num corresponds with the row that this button is placed
    var numRunner: Int
    var frm: CGRect
    var isStop: Bool
    
    init( frame: CGRect, _ num: Int, _ isStopButton: Bool )	{
        numRunner = num
        frm = frame
        isStop = isStopButton
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
