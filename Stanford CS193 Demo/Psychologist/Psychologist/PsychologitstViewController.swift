//
//  ViewController.swift
//  Psychologist
//
//  Created by 董林森 on 16/2/12.
//  Copyright © 2016年 Luke. All rights reserved.
//

import UIKit

class PsychologitsViewController: UIViewController {
    
    
    @IBAction func nothing(sender: UIButton) {
        performSegueWithIdentifier("nothing", sender: nil)
    }
    
    
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        var destinaton = segue.destinationViewController as? UIViewController
        if let navCon = destinaton as? UINavigationController {
            destinaton = navCon.visibleViewController
        }
        if let hvc = destinaton as? HappinessViewController {
            if let identifier = segue.identifier {
                switch identifier { 
                    case "sad": hvc.happiness = 0
                    case "happy": hvc.happiness = 100
                    case "meh": hvc.happiness = 25
                    case "nothing": hvc.happiness = 50
                    default: hvc.happiness = 40
                }
            }
        }
    }
    
}

