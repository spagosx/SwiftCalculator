//
//  Brain.swift
//  SwiftCalculator
//
//  Created by Spagnolo, Daniele on 07/06/2014.
//  Copyright (c) 2014 Handstream. All rights reserved.
//

import UIKit

class Brain: NSObject {
   
    var operand = String()
    var waitingForOperand = Bool()
    var waitingOperand = String()
    var waitingOperation = String()
    
    func performOperation(operation: String) ->String {
        switch operation {
        case "=":
            let originalOperand = operand
            
            performWaitingOperation()
            
            if !waitingForOperand {
                waitingOperand = originalOperand
                waitingForOperand = true
            }
        
        case "+", "-", "x", "/" :
            if !waitingForOperand {
                performWaitingOperation()
            }
            waitingOperand = operand
            waitingOperation = operation
            
        default:
            break
        }
        
        return operand
    }
    
    
    func performWaitingOperation() {
        
        let toOperand = operand.bridgeToObjectiveC()
        let toWaitingOperand = waitingOperand.bridgeToObjectiveC()
        
        switch waitingOperation {
            
        case "+":
            operand = "\(toOperand.floatValue + toWaitingOperand.floatValue)"
            
        case "x":
            operand = "\(toOperand.floatValue * toWaitingOperand.floatValue)"
            
        case "-":
            operand = waitingForOperand ?
                "\(toOperand.floatValue - toWaitingOperand.floatValue)" :
            "\(toWaitingOperand.floatValue - toOperand.floatValue)"
            
        case "/":
            operand = waitingForOperand ?
                "\(toOperand.floatValue / toWaitingOperand.floatValue)" :
            "\(toWaitingOperand.floatValue / toOperand.floatValue)"
            
        default:
            waitingForOperand = true
        }
    }
    
    func clearTapped() {
        waitingOperand = ""
        waitingOperation = ""
        operand = ""
    }
    
    func setNotWaitingForOperand() {
        waitingForOperand = false
    }
    
} //EOF
