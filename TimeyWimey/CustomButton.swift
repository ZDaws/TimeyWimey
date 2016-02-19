//
//  CustomButton.swift
//  TimeyWimey
//
//  Created by KUSKE, JOEL on 2/19/16.
//  Copyright © 2016 Frands. All rights reserved.
//

import UIKit

class CustomButton: UIButton {
    
    //Instance Variables
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
