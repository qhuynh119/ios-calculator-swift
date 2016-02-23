//
//  ViewController.swift
//  Calculator
//
//  Created by Quan K. Huynh on 2/17/16.
//  Copyright © 2016 QHProductions. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var isTypingNumber = false
    var firstNumber    = 0.0
    var secondNumber   = 0.0
    var operation      = ""

    @IBOutlet weak var calculatorDisplay: UILabel!
    
    @IBOutlet weak var backspaceButton: UIButton!
    
    /* 0 -> 9 */
    @IBAction func numbersTapped(sender: AnyObject) {
        let number = sender.currentTitle
        
        backspaceButton.setTitle("C", forState: UIControlState.Normal)
        
        if (isTypingNumber) {
            if (calculatorDisplay.text == "0") {
                if (sender.currentTitle != "0") {
                    calculatorDisplay.text = (number as String!)
                }
            } else if (calculatorDisplay.text == "-0") {
                if (sender.currentTitle != "0") {
                    calculatorDisplay.text = "-" + (number as String!)
                }
            } else {
                calculatorDisplay.text = calculatorDisplay.text! + (number as String!)
            }
        } else {
            calculatorDisplay.text = (number as String!)
            isTypingNumber = true
        }
    }
    
    /* +, -, x, / */
    @IBAction func calculationTapped(sender: AnyObject) {
        isTypingNumber = false
        firstNumber    = Double(calculatorDisplay.text!)!
        operation      = sender.currentTitle!!
    }
    
    /* AC/C, +/-, %, . */
    @IBAction func optionsTapped(sender: AnyObject) {
        let option = sender.currentTitle!!
        var text   = calculatorDisplay.text
        
        switch option {
        case ".":
            if (calculatorDisplay.text?.containsString(".") == false) {
                calculatorDisplay.text = calculatorDisplay.text! + "."
            }
            
            break
        case "C":
            if (text?.characters.count > 1) {
                if (text?.characters.count == 2 && text![(text?.startIndex)!] == "-") {
                    calculatorDisplay.text = "0"
                    backspaceButton.setTitle("AC", forState: UIControlState.Normal)
                } else {
                    calculatorDisplay.text = text?.substringToIndex(text!.endIndex.advancedBy(-1))
                }
            } else if (text?.characters.count == 1) {
                calculatorDisplay.text = "0"
                backspaceButton.setTitle("AC", forState: UIControlState.Normal)
            }
            
            break
        case "AC":
            calculatorDisplay.text = "0"
            firstNumber  = 0.0
            secondNumber = 0.0
            operation    = ""
            
            break
        case "%":
            calculatorDisplay.text = "\(Double(calculatorDisplay.text!)! / 100)"
            
            break
        case "+/-":
            if (text![(text?.startIndex)!] != "-") {
                text?.insert("-", atIndex: (text?.startIndex)!)
                calculatorDisplay.text = text
            } else {
                calculatorDisplay.text = text?.substringFromIndex(text!.startIndex.advancedBy(1))
            }
            
            break
        default:
            break
        }
    }
    
    /* = */
    @IBAction func equalsTapped(sender: AnyObject) {
        if (operation != "") {
            isTypingNumber = false
            secondNumber   = Double(calculatorDisplay.text!)!
        
            var result = 0.0
        
            switch operation {
            case "+":
                result = firstNumber + secondNumber
                break
            case "-":
                result = firstNumber - secondNumber
                break
            case "X":
                result = firstNumber * secondNumber
                break
            case "/":
                result = firstNumber / secondNumber
                break
            default:
                break
            }
        
            var str_result = String(result)
            let range      = Range<String.Index>(start: str_result.endIndex.advancedBy(-2), end: str_result.endIndex)
            let str_result_last_two_chars = str_result.substringWithRange(range)
            
            if (str_result_last_two_chars == ".0") {
                str_result = str_result.substringToIndex(str_result.endIndex.advancedBy(-2))
            }
            
            calculatorDisplay.text = str_result
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        calculatorDisplay.text = "0"
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

