//
//  PsychologitsViewController.swift
//  PsychologistV1.0
//
//  Created by 董林森 on 16/3/8.
//  Copyright © 2016年 Luke. All rights reserved.
//

import UIKit

class PsychologitsViewController: UIViewController {

    @IBAction func nothing(sender: UIButton) {
        performSegueWithIdentifier("nothing", sender: nil)
    }
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        var destation =  segue.destinationViewController as? UIViewController
        if let navCon = destation as? UINavigationController {
            destation = navCon.visibleViewController
        }
        if let hvc = destation as? HappinessViewController {
            if let identifier = segue.identifier {
                switch identifier {
                    case "happy": hvc.happiness = 100
                    case "sad": hvc.happiness = 0
                    case "meh": hvc.happiness = 80
                    case "nothing": hvc.happiness = 50
                    default: hvc.happiness = 50
                }
            }
        }
    }

}
