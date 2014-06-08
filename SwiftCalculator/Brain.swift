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
            
        case "%":
            if operand != "0" {operand = "\(operand.bridgeToObjectiveC().doubleValue/100)"}
            
        case "+/-":
            if operand != "0" {operand = "\(operand.bridgeToObjectiveC().doubleValue * -1)"}
            
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
            operand = "\(toOperand.doubleValue + toWaitingOperand.doubleValue)"
            
        case "x":
            operand = "\(toOperand.doubleValue * toWaitingOperand.doubleValue)"
            
        case "-":
            operand = waitingForOperand ?
                "\(toOperand.doubleValue - toWaitingOperand.doubleValue)" :
            "\(toWaitingOperand.doubleValue - toOperand.doubleValue)"
            
        case "/":
            operand = waitingForOperand ?
                "\(toOperand.doubleValue / toWaitingOperand.doubleValue)" :
            "\(toWaitingOperand.doubleValue / toOperand.doubleValue)"
            
            
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
