//
//  ViewController.swift
//  CalculatorSelfWriting
//
//  Created by 董林森 on 16/2/11.
//  Copyright © 2016年 Luke. All rights reserved.
//

import UIKit

class ViewController: UIViewController { //View + Controller
    
    var userInMiddleInput = false
    
    @IBOutlet weak var display: UILabel!
    
    let calculatorBrain = CalculatorBrain()
    
    @IBAction func appendDigit(sender: UIButton) {
        let operand = sender.currentTitle!
        if userInMiddleInput {
            display.text = display.text! + operand
        }else {
            display.text = operand
            userInMiddleInput = true
        }
    }
    
    @IBAction func enter() {
        userInMiddleInput = false
        if let result = calculatorBrain.pushOperand(displayValue) {
            displayValue = result
        } else {
            displayValue = 0
        }
    }
    
    @IBAction func operate(sender: UIButton) {
        if userInMiddleInput {
            enter()
        }
        if let op = sender.currentTitle {
            if let result = calculatorBrain.performOperator(op) {
                displayValue = result
                } else {
                displayValue = 0
            }
        }
        
        
    }
    
    var displayValue: Double{
        get{
            return NSNumberFormatter().numberFromString(display.text!)!.doubleValue
        }
        set{
            display.text = "\(newValue)"
            userInMiddleInput = false
        }
    }
}

