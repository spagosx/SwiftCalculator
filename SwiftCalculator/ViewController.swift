//
//  ViewController.swift
//  SwiftCalculator
//
//  Created by Spagnolo, Daniele on 06/06/2014.
//  Copyright (c) 2014 spagosx. All rights reserved.
//

import UIKit
import CoreFoundation

class ViewController: UIViewController {

    @IBOutlet var inputLabel: UILabel
    
    var isTypingNumber = false
    
    let calcBrain = Brain()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    var displayText: NSString = "" {
    didSet {
        inputLabel.text = displayText
    }
    }
    
    @IBAction func digitTapped(button: UIButton) {
        
        let value = button.titleLabel.text
        
        if displayText == "0" && value == "0" {
            isTypingNumber = false
            return
        }
        
        if (isTypingNumber) {
            if value != "." || value == "." && !displayText.containsString(".") {
               displayText = displayText.stringByAppendingString(value)
            }
        } else {
            displayText = value
            isTypingNumber = true
            calcBrain.setNotWaitingForOperand()
        }
        
    }
    
    @IBAction func clearTapped() {
        calcBrain.clearTapped()
        displayText = "0"
    }
    
    @IBAction func operationTapped(button: UIButton) {
        let operation = button.titleLabel.text
        
        if (isTypingNumber) {
            calcBrain.operand = displayText
            isTypingNumber = false
        }
        
        if (operation == "=") {
            if !calcBrain.waitingForOperand {
                calcBrain.operand = calcBrain.operand
                isTypingNumber = false
            } else {
                calcBrain.operand = displayText
            }
        }
        
        var result = calcBrain.performOperation(operation)

        let value = result.bridgeToObjectiveC().floatValue
        let int = result.bridgeToObjectiveC().integerValue
        if (Double(value) - Double(int) == 0) {
            // no floating
            result = "\(result.bridgeToObjectiveC().integerValue)"
        }
        
        displayText = result
    }
    
} //EOF

