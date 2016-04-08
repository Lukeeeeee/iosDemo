//
//  TextViewController.swift
//  PsychologistV1.0
//
//  Created by 董林森 on 16/3/8.
//  Copyright © 2016年 Luke. All rights reserved.
//

import UIKit

class TextViewController: UIViewController {
    
    @IBOutlet weak var textView: UITextView! {
        didSet {
            textView.text = text
        }
    }
    
    var text: String = "" {
        didSet {
            textView?.text = text
        }
    }
    
    override var preferredContentSize: CGSize {
        get {
            if textView != nil && presentingViewController != nil {
                return textView.sizeThatFits(presentingViewController!.view.bounds.size)
            } else {
                return super.preferredContentSize
            }
            
        }
        set {
            super.preferredContentSize = newValue
        }
    }
    

}
