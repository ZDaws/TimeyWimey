//
//  CustomTextField.swift
//  TimeyWimey
//
//  Created by HOLM, JOEL on 2/5/16.
//  Copyright © 2016 Frands. All rights reserved.
//

import UIKit

/* This class represents a UITextField
 * It is of the type UITextField so it works exactly like a UITextField
 * The only difference is that it has some extra instance variables
 */
class CustomTextField: UITextField {
    
    //This instance varable helps edit screen to know which textfield was used
    var num: Int
    
    init( frame: CGRect, _ parnum: Int)	{
        num = parnum
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
