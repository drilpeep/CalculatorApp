//
//  ViewController.swift
//  Calculator
//
//  Created by AtomSpace on 8/4/21.
//  Copyright © 2021 AtomSpace. All rights reserved.
//

import UIKit

class MyButton: UIButton {
    convenience init(type: UIButton.ButtonType) {
        self.init(type: type)
        clipsToBounds = true
    }
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        clipsToBounds = true
    }
    override init (frame: CGRect) {
        super.init(frame: frame)
        clipsToBounds = true
    }
    override var clipsToBounds: Bool {
        didSet {
            layer.cornerRadius = 10
        }
    }
}

class ViewController: UIViewController {
    
    var dotIsPlaced:Bool = false
    var numberFromScreen:Double = 0
    var firstNum:Double = 0
    var mathSign:Bool = false
    var operation:Int = 0
    var stillTyping:Bool = true
    
    var resultValue: Double = 0 {
        didSet {
            sendNumber(num: resultValue)
        }
    }
    
    @IBOutlet weak var result: UILabel!
    @IBAction func digits(_ sender: UIButton) {
        
        if mathSign == true {
            result.text = String(sender.tag)
            mathSign = false
        }
        else {
            result.text = result.text! + String(sender.tag)
        }
        numberFromScreen = Double(result.text!)!
        stillTyping = false
    }
    
    private func sendNumber(num: Double) {
        if num.rounded(.up) == num.rounded(.down){
            //number is integer
            result.text = "\(Int(num))"
        } else {
            //number is not integer
            result.text = "\(num)"
        }
        
    }
    
    @IBAction func dotButtonPressed(_ sender: UIButton) {
        if stillTyping && dotIsPlaced  {
            result.text = "\(resultValue)."
        } else if !stillTyping && !dotIsPlaced {
            result.text = "0."
        }
        stillTyping = false
    }
    
    @IBAction func buttons(_ sender: UIButton) {
        
        if result.text != "" && sender.tag != 10 && sender.tag != 15 && sender.tag != 16 {
            firstNum = Double(result.text!)!
            operation = sender.tag
            mathSign = true
        }
        else if sender.tag == 15 {
            if operation == 11 {
                resultValue = firstNum / numberFromScreen
                stillTyping = false
            }
            else if operation == 12 {
                resultValue = firstNum * numberFromScreen
                stillTyping = false
            }
            else if operation == 14 {
                resultValue = firstNum + numberFromScreen
                stillTyping = false
            }
            else if operation == 13 {
                resultValue = firstNum - numberFromScreen
                stillTyping = false
            }
            else if operation == 17 {
                resultValue = firstNum / 100 * numberFromScreen
                stillTyping = false
            }
        }
        else if sender.tag == 10 {
            result.text = ""
            firstNum = 0
            operation = 0
            mathSign = false
        }
    }
    
    @IBAction func plusMinusTapped(_ sender: Any) {
        var value = Double(result.text ?? "0")!
        value *= (-1)
        resultValue = value
    }
    
}

extension FloatingPoint {
    func isInteger() -> Bool {
        return rounded() == self
    }
}
