//
//  Preview.swift
//  TimeyWimey
//
//  Created by KUSKE, JOEL on 4/15/16.
//  Copyright © 2016 Frands. All rights reserved.
//

import UIKit

class Preview: UIViewController {

    var screenSize: CGRect = UIScreen.mainScreen().bounds
    var width: CGFloat = 0.0
    var height: CGFloat = 0.0
    
    
    
    
    
    @IBOutlet weak var scrollView: UIScrollView!
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        width = screenSize.width
        height = screenSize.height
        
        scrollView.contentInset = UIEdgeInsetsMake(0, 0, 0, 600)
        
        
        let button = UIButton(frame: CGRect(x: width / 3, y: height - 200 , width: width / 3, height: 400))
        button.backgroundColor = UIColor.redColor()
        button.addTarget(self, action: "stop:", forControlEvents: .TouchUpInside)
        self.scrollView.addSubview(button)
        
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    func stop(sender: UIButton) {
        if self.scrollView.scrollEnabled {
            self.scrollView.scrollEnabled = false
        } else {
            self.scrollView.scrollEnabled = true
        }
    }
    
    
    
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        
        self.scrollView.frame = self.view.bounds
        self.scrollView.contentSize.height = 0
        self.scrollView.contentSize.width = 2000
        
    }
    
    
    
    @IBAction func backButton(sender: UIBarButtonItem) {
        
        
        performSegueWithIdentifier("previewToTimerSegue", sender: self)
        
    }
    
    
    
    
    
}
