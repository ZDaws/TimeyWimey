//
//  CustomTextField.swift
//  TimeyWimey
//
//  Created by KUSKE, JOEL on 2/5/16.
//  Copyright © 2016 Frands. All rights reserved.
//

import UIKit

class CustomTextField: UITextField {
    
    
    var num: Int
    
    init( frame: CGRect, _ parnum: Int)	{
        num = parnum
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    

}
